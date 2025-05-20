SHELL := /bin/bash

-include $(shell curl -sSL -o .tardigrade-ci "https://raw.githubusercontent.com/plus3it/tardigrade-ci/master/bootstrap/Makefile.bootstrap"; echo .tardigrade-ci)

export AWS_DEFAULT_REGION

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
	pipenv run terragrunt run --all --working-dir dev --source-update -- plan -lock=false

deploy/dev: | guard/deps
	@echo "[$@]: Deploying 'dev' pipeline!"
	pipenv run terragrunt run --all --working-dir dev --source-update -- plan -lock=false -out tfplan
	pipenv run terragrunt run --all --working-dir dev -- apply tfplan
	aws cloudfront create-invalidation --distribution-id $$WRANGLER_DISTRIBUTION --paths "/yum.defs*"

deploy/release: | guard/deps guard/env/DEV_BUCKET
	@echo "[$@]: Deploying 'release' pipeline!"
	pipenv run terragrunt run --working-dir release/bucket-list --source-update -- plan -lock=false -out tfplan
	pipenv run terragrunt run --working-dir release/bucket-list -- apply tfplan
	pipenv run terragrunt run --all --working-dir release --queue-exclude-dir bucket-list --source-update -- plan -lock=false -out tfplan
	pipenv run terragrunt run --all --working-dir release --queue-exclude-dir bucket-list -- apply tfplan
	aws cloudfront create-invalidation --distribution-id $$WRANGLER_DISTRIBUTION --paths "/yum.defs*"
