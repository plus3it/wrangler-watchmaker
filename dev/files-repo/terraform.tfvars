uri_map = {
  # python for windows
  "https://www.python.org/ftp/python/3.6.8/python-3.6.8-amd64.exe"   = "python/python/"
  "https://www.python.org/ftp/python/3.8.7/python-3.8.7-amd64.exe"   = "python/python/"
  "https://www.python.org/ftp/python/3.8.10/python-3.8.10-amd64.exe" = "python/python/"
  "https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe"   = "python/python/"

  # get-pip
  "https://bootstrap.pypa.io/get-pip.py"         = "python/pip/"
  "https://bootstrap.pypa.io/pip/2.6/get-pip.py" = "python/pip/2.6/"

  # salt for windows
  "https://archive.repo.saltproject.io/windows/Salt-Minion-3004-2-Py3-AMD64-Setup.exe"    = "saltstack/salt/windows/"
  "https://archive.repo.saltproject.io/windows/Salt-Minion-3003.3-Py3-AMD64-Setup.exe"    = "saltstack/salt/windows/"
  "https://repo.saltproject.io/windows/Salt-Minion-3004.2-1-Py3-AMD64-Setup.exe"          = "saltstack/salt/windows/"
  "https://repo.saltproject.io/windows/Salt-Minion-3005.1-Py3-AMD64-Setup.exe"            = "saltstack/salt/windows/" # classic
  "https://repo.saltproject.io/salt/py3/windows/3005.1-2/salt-3005.1-2-windows-amd64.exe" = "saltstack/salt/windows/" # onedir


  # spawar scc
  "s3://wrangler-watchmaker-filecache/spawar/scc/SCC_5.5_Windows_Setup.exe" = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/scc-5.5.rhel7.x86_64.rpm"  = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/scc-5.5.rhel8.x86_64.rpm"  = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/RPM-GPG-KEY-scc-5.5"       = "spawar/scc/"
}

prefix = "repo/"
