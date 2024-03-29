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

guard/deploy: | guard/env/TF_VAR_bucket_name
guard/deploy: | guard/env/TF_VAR_repo_endpoint
guard/deploy: | guard/env/AWS_DEFAULT_REGION
guard/deploy: | guard/env/WRANGLER_BUCKET
guard/deploy: | guard/env/WRANGLER_DDB_TABLE
guard/deploy: | guard/env/WRANGLER_DISTRIBUTION
guard/deploy: | guard/program/pipenv
guard/deploy: | guard/program/rclone
guard/deploy: | guard/program/terraform
guard/deploy: | guard/program/terragrunt

deploy/dev: | guard/deploy
	@echo "[$@]: Deploying 'dev' pipeline!"
	pipenv run terragrunt plan-all -out tfplan --terragrunt-working-dir dev --terragrunt-source-update
	pipenv run terragrunt apply-all tfplan --terragrunt-working-dir dev
	aws cloudfront create-invalidation --distribution-id $$WRANGLER_DISTRIBUTION --paths "/yum.defs*"

deploy/release: | guard/deploy guard/env/DEV_BUCKET
	@echo "[$@]: Deploying 'release' pipeline!"
	pipenv run terragrunt plan -out tfplan --terragrunt-working-dir release/bucket-list --terragrunt-source-update
	pipenv run terragrunt apply tfplan --terragrunt-working-dir release/bucket-list
	pipenv run terragrunt plan-all -out tfplan --terragrunt-working-dir release --terragrunt-source-update --terragrunt-exclude-dir bucket-list > /dev/null
	pipenv run terragrunt apply-all tfplan --terragrunt-working-dir release --terragrunt-exclude-dir bucket-list > /dev/null
	aws cloudfront create-invalidation --distribution-id $$WRANGLER_DISTRIBUTION --paths "/yum.defs*"
