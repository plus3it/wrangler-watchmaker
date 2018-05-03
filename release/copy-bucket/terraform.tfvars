terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  dependencies {
    paths = ["../bucket"]
  }

  terraform = {
    after_hook "render" {
      commands = ["init"]
      execute  = ["python", "render.py"]
    }

    before_hook "render" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
      execute  = ["python", "render.py"]
    }
  }
}
