moved {
  from = aws_s3_object.this["yum.defs/saltstack/salt/3006.4/salt-reposync-amzn2-onedir.repo"]
  to   = aws_s3_object.this_3006_4_amzn2_onedir
}

removed {
  from = aws_s3_object.this_3006_4_amzn2_onedir

  lifecycle {
    destroy = false
  }
}

moved {
  from = aws_s3_object.this["yum.defs/saltstack/salt/3006.4/salt-reposync-amzn2-python3.repo"]
  to   = aws_s3_object.this_3006_4_amzn2_python3
}

removed {
  from = aws_s3_object.this_3006_4_amzn2_python3

  lifecycle {
    destroy = false
  }
}

moved {
  from = aws_s3_object.this["yum.defs/saltstack/salt/3006.4/salt-reposync-el8-onedir.repo"]
  to   = aws_s3_object.this_3006_4_el8_onedir
}

removed {
  from = aws_s3_object.this_3006_4_el8_onedir

  lifecycle {
    destroy = false
  }
}

moved {
  from = aws_s3_object.this["yum.defs/saltstack/salt/3006.4/salt-reposync-el8-python3.repo"]
  to   = aws_s3_object.this_3006_4_el8_python3
}

removed {
  from = aws_s3_object.this_3006_4_el8_python3

  lifecycle {
    destroy = false
  }
}

moved {
  from = aws_s3_object.this["yum.defs/saltstack/salt/3006.4/salt-reposync-el9-onedir.repo"]
  to   = aws_s3_object.this_3006_4_el9_onedir
}

removed {
  from = aws_s3_object.this_3006_4_el9_onedir

  lifecycle {
    destroy = false
  }
}
