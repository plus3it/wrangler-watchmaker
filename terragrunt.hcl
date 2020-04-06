remote_state {
  backend = "s3"

  config = {
    bucket         = get_env("WRANGLER_BUCKET", "")
    key            = "tfstate/${path_relative_to_include()}/terraform.tfstate"
    encrypt        = true
    dynamodb_table = get_env("WRANGLER_DDB_TABLE", "")
    region         = get_env("AWS_DEFAULT_REGION", "")
  }
}

terraform_version_constraint = ">= 0.11"

terraform {
  source = "git::https://github.com/plus3it/terraform-aws-wrangler.git?ref=1.3.4"

  after_hook "common" {
    commands = ["init-from-module"]
    execute  = ["cp", "${get_parent_terragrunt_dir()}/common.tf", "."]
  }

  after_hook "tfvars" {
    commands = ["init-from-module"]
    execute  = ["cp", "${get_terragrunt_dir()}/wrangler.auto.tfvars", "."]
  }

  after_hook "requirements" {
    commands = ["init-from-module"]
    execute  = ["pip", "install", "-r", "requirements.txt"]
  }

  after_hook "render" {
    commands = ["init-from-module"]
    execute  = ["python", "render.py", "-var-file", "wrangler.auto.tfvars"]
  }
}
