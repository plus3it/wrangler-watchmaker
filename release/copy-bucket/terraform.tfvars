terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform = {
    after_hook "tfvars" {
      execute = ["echo"]
    }

    after_hook "render" {
      commands = ["init-from-module"]
      execute  = ["python", "render.py"]
    }
  }
}
