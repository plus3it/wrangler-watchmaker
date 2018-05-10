FIND_JSON ?= find . -name '*.json' -type f
XARGS_CMD ?= xargs -I {}
TERRAFORM_VERSION ?= $(shell curl -sSL https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')
TERRAFORM_URL ?= https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_linux_amd64.zip
TERRAGRUNT_RELEASES ?= $(shell curl -sSL https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest?access_token=4224d33b8569bec8473980bb1bdb982639426a92)
TERRAGRUNT_URL ?= $(shell echo '$(TERRAGRUNT_RELEASES)' | jq --raw-output  '.assets[] | select(.name=="terragrunt_linux_amd64") | .browser_download_url')

guard-% :
	@ if [ "${${*}}" = "" ]; then \
		echo "Make/environment variable $* not set"; \
		exit 1; \
	fi

.PHONY: json.lint
json.lint:
	$(FIND_JSON) | $(XARGS_CMD) bash -c 'cmp {} <(jq --indent 4 -S . {}) || (echo "[{}]: Failed JSON Lint Test"; exit 1)'

.PHONY: tf.lint
tf.lint: tf.tools
	terraform fmt -check=true

.PHONY: tf.tools
tf.tools:
	@echo "[make]: TERRAFORM_URL=$(TERRAFORM_URL)"
	curl -sSL -o terraform.zip "$(TERRAFORM_URL)"
	unzip terraform.zip && rm -f terraform.zip && chmod +x terraform
	mkdir -p ${HOME}/bin && export PATH=${HOME}/bin:${PATH} && mv terraform ${HOME}/bin/
	terraform --version

.PHONY: tg.tools
tg.tools:
	@echo "[make]: TERRAGRUNT_URL=$(TERRAGRUNT_URL)"
	curl -sSL -o terragrunt "$(TERRAGRUNT_URL)"
	chmod +x terragrunt
	mv terragrunt ${HOME}/bin
	terragrunt --version

.PHONY: deploy.dev
deploy.dev: guard-DEV_BUCKET
	@echo "[make]: Deploying to dev environment!"
	TF_VAR_bucket_name=$(DEV_BUCKET) \
		terragrunt plan-all -out tfplan --terragrunt-working-dir dev --terragrunt-source-update
	TF_VAR_bucket_name=$(DEV_BUCKET) \
		terragrunt apply-all tfplan --terragrunt-working-dir dev

.PHONY: deploy.release
deploy.release: guard-RELEASE_BUCKET guard-RELEASE_OBJECTS_MAP
	@echo "[make]: Deploying to release environment!"
	TF_VAR_bucket_name=$(RELEASE_BUCKET) \
	TF_VAR_s3_objects_map=$(RELEASE_OBJECTS_MAP) \
		terragrunt plan-all -out tfplan --terragrunt-working-dir release --terragrunt-source-update
	TF_VAR_bucket_name=$(RELEASE_BUCKET) \
	TF_VAR_s3_objects_map=$(RELEASE_OBJECTS_MAP) \
		terragrunt apply-all tfplan --terragrunt-working-dir release
