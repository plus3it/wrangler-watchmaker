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

generate "common.tf" {
  path      = "common.tf"
  if_exists = "overwrite"
  contents  = file("${get_parent_terragrunt_dir()}/common.tf")
}
