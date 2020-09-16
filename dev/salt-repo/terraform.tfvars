repos = [
  {
    repo_prefix      = "repo/saltstack/salt/linux/"
    salt_s3_endpoint = "https://s3.repo.saltstack.com/"
    yum_prefix       = "yum.defs/saltstack/salt/"
    salt_versions = [
      "2019.2.5",
      "3000.3",
      "3001.1",
    ]
  },
  {
    repo_prefix      = "repo/archive/saltstack/salt/linux/"
    salt_s3_endpoint = "https://s3.archive.repo.saltstack.com/"
    yum_prefix       = "yum.defs/saltstack/salt/"
    salt_versions = [
      "2018.3.4",
    ]
  },
]
