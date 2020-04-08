include {
  path = find_in_parent_folders()
}

terraform {
  source = "./"

  extra_arguments "bucket" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var",
      "bucket_name=${get_env("DEV_BUCKET", "")}",
    ]
  }
}

inputs = {
  prefix = "repo/"
}
