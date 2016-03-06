TOPDIR := $(dir $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))

LOGDIR=/var/lib/litelog
LITELOGDIR=/usr/lib/litelog

SERVICESYSTEM=$(shell {\
	systemctl status default.target >/dev/null 2>&1 && echo 'systemd'\
	} || {\
	rc-status default >/dev/null 2>&1 && echo 'openrc'\
	} || {
	crontab -l >/dev/null 2>&1 && echo 'cron'\
	} || echo 'none')
LITELOGSHDIR=$(LITELOGDIR)/sh

MODULEDIR=$(LITELOGSHDIR)/$(MODULE)
MODULELOGDIR=$(LOGDIR)/$(MODULE)
MODULE_FILES=$(wildcard *.sh *functions)
SYSTEMD_FILES=$(wildcard *.service *.timer *.path)
UDEV_FILES=$(wildcard *.rules)

install-base: /etc/litelog $(LOGDIR)

install-module: install-base
	mkdir -p "$(MODULEDIR)"
	mkdir -p "$(MODULELOGDIR)"
	-cp -va $(MODULE_FILES) "$(MODULEDIR)"
	-cp -va $(SYSTEMD_FILES) /lib/systemd/system
	-cp -va $(UDEV_FILES) /etc/udev/rules.d

uninstall-module:
	-cd /lib/systemd/system && rm $(SYSTEMD_FILES)
	-cd /etc/udev/rules.d && rm $(UDEV_FILES)
	-rm -rf "$(MODULEDIR)"

/etc/litelog:
	echo LITELOGDIR='"$(LITELOGDIR)"' > /etc/litelog;
	echo LOGDIR='"$(LOGDIR)"' >> /etc/litelog;
	echo HOSTNAME='"$(shell hostname)"' >> /etc/litelog;

$(LITELOGSHDIR)/functions: $(TOPDIR)/*functions
	mkdir -p "$(LITELOGSHDIR)"
	cp -v $(TOPDIR)/*functions "$(LITELOGSHDIR)"

$(LOGDIR):
	mkdir -p "$(LOGDIR)"

