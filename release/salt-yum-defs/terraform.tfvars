terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  dependencies {
    paths = ["../copy-bucket"]
  }

  terraform {
    source = "git::https://github.com/plus3it/salt-reposync.git//defs?ref=2.1.1"

    after_hook "requirements" {
      commands = ["init-from-module"]
      execute  = ["pip", "install", "awscli"]
    }

    after_hook "render" {
      execute = ["echo"]
    }

    before_hook "render" {
      execute = ["echo"]
    }
  }
}
