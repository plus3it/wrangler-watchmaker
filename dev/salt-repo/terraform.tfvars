terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  dependencies {
    paths = ["../files-repo"]
  }

  terraform {
    source = "git::https://github.com/plus3it/salt-reposync.git?ref=2.1.1"


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
