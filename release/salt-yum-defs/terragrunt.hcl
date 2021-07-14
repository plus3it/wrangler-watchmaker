include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/plus3it/salt-reposync.git//modules/defs?ref=5.0.2"
}

dependencies {
  paths = ["../copy-bucket"]
}
