uri_map = {
  # python for windows
  "https://www.python.org/ftp/python/3.13.9/python-3.13.9-amd64.exe"   = "python/python/"
  "https://www.python.org/ftp/python/3.13.3/python-3.13.3-amd64.exe"   = "python/python/"
  "https://www.python.org/ftp/python/3.12.10/python-3.12.10-amd64.exe" = "python/python/"

  # get-pip
  "https://bootstrap.pypa.io/get-pip.py" = "python/pip/"

  # salt for windows
  "https://packages.broadcom.com/artifactory/saltproject-generic/windows/3007.8/Salt-Minion-3007.8-Py3-AMD64-Setup.exe" = "saltstack/salt/windows/"
  "https://packages.broadcom.com/artifactory/saltproject-generic/windows/3007.2/Salt-Minion-3007.2-Py3-AMD64-Setup.exe" = "saltstack/salt/windows/"

  # spawar scc
  "s3://wrangler-watchmaker-filecache/spawar/scc/SCC_5.7.1_Windows_Setup.exe" = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/scc-5.7.1.rhel8.x86_64.rpm"  = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/scc-5.7.1.rhel9.x86_64.rpm"  = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/SCC_5.9_Windows_Setup.exe"   = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/scc-5.9.rhel8.x86_64.rpm"    = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/scc-5.9.rhel9.x86_64.rpm"    = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/SCC_5.10_Windows_Setup.exe"  = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/scc-5.10.rhel8.x86_64.rpm"   = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/scc-5.10.rhel9.x86_64.rpm"   = "spawar/scc/"
}

prefix = "repo/"
