include "root" {
  path = find_in_parent_folders("terragrunt-root.hcl")
}

terraform {
  source = "git::https://github.com/plus3it/terraform-aws-wrangler.git//?ref=4.0.2"
}
