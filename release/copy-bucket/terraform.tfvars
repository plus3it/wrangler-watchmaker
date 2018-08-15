terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  dependencies {
    paths = ["../bucket"]
  }

  terraform = {
    after_hook "tfvars" {
      execute = ["echo"]
    }

    after_hook "render" {
      commands = ["init-from-module"]
      execute  = ["pipenv", "run", "python", "render.py"]
    }
  }
}
