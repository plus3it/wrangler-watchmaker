SHELL := /bin/bash

-include $(shell curl -sSL -o .tardigrade-ci "https://raw.githubusercontent.com/plus3it/tardigrade-ci/master/bootstrap/Makefile.bootstrap"; echo .tardigrade-ci)

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
guard/deploy: | guard/program/pipenv
guard/deploy: | guard/program/rclone
guard/deploy: | guard/program/terraform
guard/deploy: | guard/program/terragrunt

deploy/%: | guard/deploy %
	@echo "[$@]: Deploying '$*' pipeline!"
	pipenv run terragrunt apply-all --terragrunt-working-dir $* --terragrunt-source-update
