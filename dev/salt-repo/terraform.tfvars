repos = [
  {
    repo_type = "webdav"

    repo_prefix = "repo/saltstack/salt/linux/rpm/"
    yum_prefix  = "yum.defs/saltstack/salt/"

    salt_gpgkey_url = "https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public"
    salt_webdav_url = "https://packages.broadcom.com/artifactory/"
    salt_versions = [
      "3007.8",
      "3007.2",
    ]
  },
]
