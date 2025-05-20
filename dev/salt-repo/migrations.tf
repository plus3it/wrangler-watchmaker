moved {
  from = module.yum_defs.aws_s3_object.this["yum.defs/saltstack/salt/3006.4/salt-reposync-amzn2-onedir.repo"]
  to   = module.yum_defs.aws_s3_object.this_3006_4_amzn2_onedir
}

removed {
  from = module.yum_defs.aws_s3_object.this_3006_4_amzn2_onedir

  lifecycle {
    destroy = false
  }
}

moved {
  from = module.yum_defs.aws_s3_object.this["yum.defs/saltstack/salt/3006.4/salt-reposync-amzn2-python3.repo"]
  to   = module.yum_defs.aws_s3_object.this_3006_4_amzn2_python3
}

removed {
  from = module.yum_defs.aws_s3_object.this_3006_4_amzn2_python3

  lifecycle {
    destroy = false
  }
}

moved {
  from = module.yum_defs.aws_s3_object.this["yum.defs/saltstack/salt/3006.4/salt-reposync-el8-onedir.repo"]
  to   = module.yum_defs.aws_s3_object.this_3006_4_el8_onedir
}

removed {
  from = module.yum_defs.aws_s3_object.this_3006_4_el8_onedir

  lifecycle {
    destroy = false
  }
}

moved {
  from = module.yum_defs.aws_s3_object.this["yum.defs/saltstack/salt/3006.4/salt-reposync-el8-python3.repo"]
  to   = module.yum_defs.aws_s3_object.this_3006_4_el8_python3
}

removed {
  from = module.yum_defs.aws_s3_object.this_3006_4_el8_python3

  lifecycle {
    destroy = false
  }
}

moved {
  from = module.yum_defs.aws_s3_object.this["yum.defs/saltstack/salt/3006.4/salt-reposync-el9-onedir.repo"]
  to   = module.yum_defs.aws_s3_object.this_3006_4_el9_onedir
}

removed {
  from = module.yum_defs.aws_s3_object.this_3006_4_el9_onedir

  lifecycle {
    destroy = false
  }
}

moved {
  from = module.sync_repo.null_resource.sync_s3_onedir["https://s3.archive.repo.saltproject.io/_repo/archive/saltstack/salt/linux/"]
  to   = module.sync_repo.null_resource.sync_s3_onedir_archive
}

removed {
  from = module.sync_repo.null_resource.sync_s3_onedir_archive

  lifecycle {
    destroy = false
  }
}

moved {
  from = module.sync_repo.null_resource.sync_s3_onedir["https://s3.repo.saltproject.io/_repo/saltstack/salt/linux/"]
  to   = module.sync_repo.null_resource.sync_s3_onedir_main
}

removed {
  from = module.sync_repo.null_resource.sync_s3_onedir_main

  lifecycle {
    destroy = false
  }
}

moved {
  from = module.sync_repo.null_resource.sync_s3_python3["https://s3.archive.repo.saltproject.io/_repo/archive/saltstack/salt/linux/"]
  to   = module.sync_repo.null_resource.sync_s3_python3_archive
}

removed {
  from = module.sync_repo.null_resource.sync_s3_python3_archive

  lifecycle {
    destroy = false
  }
}

moved {
  from = module.sync_repo.null_resource.sync_s3_python3["https://s3.repo.saltproject.io/_repo/saltstack/salt/linux/"]
  to   = module.sync_repo.null_resource.sync_s3_python3_main
}

removed {
  from = module.sync_repo.null_resource.sync_s3_python3_main

  lifecycle {
    destroy = false
  }
}
