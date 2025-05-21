include "root" {
  path = find_in_parent_folders("terragrunt-root.hcl")
}

terraform {
  source = "git::https://github.com/plus3it/salt-reposync.git//modules/defs?ref=6.2.0"
}

dependency "copy_bucket" {
  config_path = "../copy-bucket"
}
