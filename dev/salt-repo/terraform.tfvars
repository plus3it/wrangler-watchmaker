terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  dependencies {
    paths = ["../files-repo"]
  }

  terraform {
    after_hook "targeted-destroy" {
      commands = ["apply"]
      execute  = ["terraform", "destroy", "-target", "module.salt_reposync", "-auto-approve"]
    }
  }
}
