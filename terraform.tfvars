terragrunt = {
  remote_state {
    backend = "s3"

    config {
      bucket         = "${get_env("WRANGLER_BUCKET", "")}"
      key            = "tfstate/${path_relative_to_include()}/terraform.tfstate"
      encrypt        = true
      dynamodb_table = "${get_env("WRANGLER_DDB_TABLE", "")}"
      region         = "${get_env("AWS_DEFAULT_REGION", "")}"
    }
  }

  terraform {
    source = "git::https://github.com/plus3it/terraform-aws-wrangler.git?ref=0.2.1"

    after_hook "common" {
      commands = ["init"]
      execute  = ["cp", "${get_parent_tfvars_dir()}/common.tf", "."]
    }

    after_hook "tfvars" {
      commands = ["init"]
      execute  = ["cp", "${get_tfvars_dir()}/*.tfvars", "."]
    }

    after_hook "requirements" {
      commands = ["init"]
      execute  = ["pip", "install", "-r", "requirements.txt"]
    }

    after_hook "render" {
      commands = ["init"]
      execute  = ["python", "render.py", "-var-file", "wrangler.auto.tfvars"]
    }

    before_hook "render" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
      execute  = ["python", "render.py", "-var-file", "wrangler.auto.tfvars"]
    }

    extra_arguments "no-color" {
      commands = [
        "apply",
        "destroy",
        "import",
        "init",
        "plan",
        "push",
        "refresh",
        "show",
        "taint",
        "validate",
        "untaint",
      ]

      arguments = [
        "-no-color",
      ]
    }
  }
}
