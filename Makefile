FIND_JSON ?= find . -name '*.json' -type f
XARGS_CMD ?= xargs -I {}
BIN_DIR ?= ${HOME}/bin
PATH := $(BIN_DIR):$(RUBY_BIN_DIR):${PATH}

MAKEFLAGS += --no-print-directory
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.SUFFIXES:

.PHONY: %/install %/lint deploy/%

guard-% :
	@ if [ "${${*}}" = "" ]; then \
		echo "Make/environment variable $* not set"; \
		exit 1; \
	fi

terraform/install: TERRAFORM_VERSION ?= $(shell curl -sSL https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')
terraform/install: TERRAFORM_URL ?= https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_linux_amd64.zip
terraform/install:
	@echo "[make]: TERRAFORM_URL=$(TERRAFORM_URL)"
	curl -sSL -o terraform.zip "$(TERRAFORM_URL)"
	unzip terraform.zip && rm -f terraform.zip && chmod +x terraform
	mv terraform "$(BIN_DIR)"
	terraform --version
	@echo "[make]: Terraform installed successfully!"

terragrunt/install: TERRAGRUNT_URL ?= $(shell curl -sSL https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest?access_token=4224d33b8569bec8473980bb1bdb982639426a92 | jq --raw-output  '.assets[] | select(.name=="terragrunt_linux_amd64") | .browser_download_url')
terragrunt/install:
	@echo "[make]: TERRAGRUNT_URL=$(TERRAGRUNT_URL)"
	curl -sSL -o terragrunt "$(TERRAGRUNT_URL)"
	chmod +x terragrunt
	mv terragrunt "$(BIN_DIR)"
	terragrunt --version
	@echo "[make]: Terragrunt installed successfully!"

json/lint: FIND_JSON := find . -not \( -name .terraform -prune \) -name '*.json' -type f
json/lint:
	@echo "[make] Linting JSON files..."
	$(FIND_JSON) | $(XARGS_CMD) bash -c 'cmp {} <(jq --indent 4 -S . {}) || (echo "[{}]: Failed JSON Lint Test"; exit 1)'
	@echo "[make] JSON files PASSED lint test!"

terraform/lint:
	@echo "[make] Linting Terraform files..."
	terraform fmt -check=true
	@echo "[make] Terraform files PASSED lint test!"

deploy/dev: guard-DEV_BUCKET
	@echo "[make]: Deploying to dev environment!"
	TF_VAR_bucket_name=$(DEV_BUCKET) \
		terragrunt plan-all -out tfplan --terragrunt-working-dir dev --terragrunt-source-update
	TF_VAR_bucket_name=$(DEV_BUCKET) \
		terragrunt apply-all tfplan --terragrunt-working-dir dev

deploy/release: guard-RELEASE_BUCKET guard-RELEASE_OBJECTS_MAP
	@echo "[make]: Deploying to release environment!"
	TF_VAR_bucket_name=$(RELEASE_BUCKET) \
	TF_VAR_s3_objects_map='$(RELEASE_OBJECTS_MAP)' \
		terragrunt plan-all -out tfplan --terragrunt-working-dir release --terragrunt-source-update
	TF_VAR_bucket_name=$(RELEASE_BUCKET) \
	TF_VAR_s3_objects_map='$(RELEASE_OBJECTS_MAP)' \
		terragrunt apply-all tfplan --terragrunt-working-dir release
