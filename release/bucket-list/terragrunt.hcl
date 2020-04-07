include {
  path = find_in_parent_folders()
}

terraform {
  source = "./"
}

inputs = {
  bucket_name = get_env("DEV_BUCKET", "")
  prefix      = "repo/"
}
