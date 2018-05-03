terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  dependencies {
    paths = ["../bucket"]
  }

  terraform {
    after_hook "filecache" {
      commands = ["init"]
      execute  = ["cp", "-r", "${get_tfvars_dir()}/.filecache", "."]
    }
  }
}
