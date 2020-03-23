uri_map = {
  # python for windows
  "https://www.python.org/ftp/python/3.6.8/python-3.6.8-amd64.exe" = "python/python/"

  # get-pip
  "https://bootstrap.pypa.io/get-pip.py"     = "python/pip/"
  "https://bootstrap.pypa.io/2.6/get-pip.py" = "python/pip/2.6/"

  # salt for windows
  "http://repo.saltstack.com/windows/Salt-Minion-2018.3.3-Py2-AMD64-Setup.exe" = "saltstack/salt/windows/"
  "http://repo.saltstack.com/windows/Salt-Minion-2018.3.4-Py2-AMD64-Setup.exe" = "saltstack/salt/windows/"
  "http://repo.saltstack.com/windows/Salt-Minion-2018.3.4-Py3-AMD64-Setup.exe" = "saltstack/salt/windows/"
}

prefix = "repo/"

s3_objects_map = {}
