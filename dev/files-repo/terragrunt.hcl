include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/plus3it/terraform-aws-wrangler.git//?ref=3.1.3"
}
