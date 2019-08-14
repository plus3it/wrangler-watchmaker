terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  dependencies {
    paths = ["../files-repo"]
  }

  terraform {
    source = "git::https://github.com/plus3it/salt-reposync.git?ref=2.0.4"


    after_hook "requirements" {
      execute = ["echo"]
    }

    after_hook "render" {
      execute = ["echo"]
    }

    before_hook "render" {
      execute = ["echo"]
    }
  }
}
