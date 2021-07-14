uri_map = {
  # python for windows
  "https://www.python.org/ftp/python/3.6.8/python-3.6.8-amd64.exe" = "python/python/"
  "https://www.python.org/ftp/python/3.8.7/python-3.8.7-amd64.exe" = "python/python/"

  # get-pip
  "https://bootstrap.pypa.io/get-pip.py"         = "python/pip/"
  "https://bootstrap.pypa.io/pip/2.6/get-pip.py" = "python/pip/2.6/"

  # salt for windows
  "https://archive.repo.saltstack.com/windows/Salt-Minion-2019.2.5-Py2-AMD64-Setup.exe" = "saltstack/salt/windows/"
  "https://archive.repo.saltstack.com/windows/Salt-Minion-2019.2.5-Py3-AMD64-Setup.exe" = "saltstack/salt/windows/"
  "https://archive.repo.saltstack.com/windows/Salt-Minion-2019.2.8-Py2-AMD64-Setup.exe" = "saltstack/salt/windows/"
  "https://archive.repo.saltstack.com/windows/Salt-Minion-2019.2.8-Py3-AMD64-Setup.exe" = "saltstack/salt/windows/"
  "https://repo.saltstack.com/windows/Salt-Minion-3003-Py3-AMD64-Setup.exe"             = "saltstack/salt/windows/"

  # spawar scc
  "s3://wrangler-watchmaker-filecache/spawar/scc/SCC_5.4.1_Windows_Setup.exe" = "spawar/scc/"
  "s3://wrangler-watchmaker-filecache/spawar/scc/scc-5.4.1.rhel7.x86_64.rpm"  = "spawar/scc/"
}

prefix = "repo/"
