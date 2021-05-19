include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/plus3it/terraform-aws-wrangler.git//?ref=3.1.2"
}

dependency "bucket_list" {
  config_path = "../bucket-list"
}

generate "uri_map" {
  path      = "uri_map.auto.tfvars"
  if_exists = "overwrite"

  # Construct map of uri => key_path without filename
  contents = <<-EOF
    uri_map = {
      %{for key in dependency.bucket_list.outputs.s3_objects.keys~}
      "s3://${dependency.bucket_list.outputs.s3_objects.bucket}/${key}" = "${trimsuffix(key, element(split("/", key), length(split("/", key)) - 1))}"
      %{endfor~}
    }
    EOF
}
