include "root" {
  path = find_in_parent_folders("terragrunt-root.hcl")
}

terraform {
  source = "git::https://github.com/plus3it/salt-reposync.git//?ref=6.2.1"
}

dependencies {
  paths = ["../files-repo"]
}
