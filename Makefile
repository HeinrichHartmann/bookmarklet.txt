PWD=$(shell pwd)
PYTHON=source venv/bin/activate; PYTHONPATH=$(PWD) python
PIP=source venv/bin/activate; PYTHONPATH=$(PWD) pip
DEPENDENCIES=aiohttp

run:
	$(PYTHON) main.py

venv:
	[ -d venv ] || virtualenv -p python3 venv
	$(PYTHON) -m pip install --upgrade pip $(DEPENDENCIES)

osx-launch-agent:
	sed -e 's#@PWD@#$(PWD)#' < bookmarkd.plist.in > com.heinrichhartmann.bookmarkd.plist
	install -m 0644	com.heinrichhartmann.bookmarkd.plist ~/Library/LaunchAgents
	# Launchctl documentation is a mess...
	# I use the proprietary LaunchControl app to manage services.
	# However, according to [1] the following should install and start the service.
	# [1] https://nathangrigg.com/2012/07/schedule-jobs-using-launchd
	launchctl load ~/Library/LaunchAgents/com.heinrichhartmann.bookmarkd.plist
	launchctl start bookmarkd
