SHELL := /bin/bash

-include $(shell curl -sSL -o .tardigrade-ci "https://raw.githubusercontent.com/plus3it/tardigrade-ci/master/bootstrap/Makefile.bootstrap"; echo .tardigrade-ci)

export AWS_DEFAULT_REGION

## Install rclone
rclone/install: RCLONE_VERSION ?= latest
rclone/install: $(BIN_DIR) guard/program/unzip
	@ echo "[$@]: Installing $(@D)..."
	$(call download_github_release,$(@D).zip,$(@D),$(@D),$(RCLONE_VERSION),.name | endswith("$(OS)-$(ARCH).zip"))
	unzip $(@D).zip
	mv $(@D)-*/$(@D) $(BIN_DIR)
	rm -rf $(@D)*
	chmod +x $(BIN_DIR)/$(@D)
	$(@D) --version

guard/deps: | guard/env/TF_VAR_bucket_name
guard/deps: | guard/env/TF_VAR_repo_endpoint
guard/deps: | guard/env/AWS_DEFAULT_REGION
guard/deps: | guard/env/WRANGLER_BUCKET
guard/deps: | guard/env/WRANGLER_DDB_TABLE
guard/deps: | guard/env/WRANGLER_DISTRIBUTION
guard/deps: | guard/program/pipenv
guard/deps: | guard/program/rclone
guard/deps: | guard/program/terraform
guard/deps: | guard/program/terragrunt

plan/dev: | guard/deps
	@echo "[$@]: Planning 'dev' pipeline!"
	pipenv run terragrunt run-all plan -lock=false --working-dir dev --source-update

deploy/dev: | guard/deps
	@echo "[$@]: Deploying 'dev' pipeline!"
	pipenv run terragrunt run-all plan -lock=false -out tfplan --working-dir dev --source-update
	pipenv run terragrunt run-all apply tfplan --working-dir dev
	aws cloudfront create-invalidation --distribution-id $$WRANGLER_DISTRIBUTION --paths "/yum.defs*"

deploy/release: | guard/deps guard/env/DEV_BUCKET
	@echo "[$@]: Deploying 'release' pipeline!"
	pipenv run terragrunt plan -lock=false -out tfplan --working-dir release/bucket-list --source-update
	pipenv run terragrunt apply tfplan --working-dir release/bucket-list
	pipenv run terragrunt run-all plan -lock=false -out tfplan --working-dir release --source-update --exclude-dir bucket-list > /dev/null
	pipenv run terragrunt run-all apply tfplan --working-dir release --exclude-dir bucket-list > /dev/null
	aws cloudfront create-invalidation --distribution-id $$WRANGLER_DISTRIBUTION --paths "/yum.defs*"
