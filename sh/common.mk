# absolute path of litelog/sh source tree
TOPDIR := $(dir $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))

# configurable
LOGDIR=/var/lib/litelog
LITELOGDIR=/usr/lib/litelog

# detects and evaluates to systemd, openrc, or cron, in that order
SERVICEMANAGER=$(shell {\
	systemctl status default.target >/dev/null 2>&1 && echo 'systemd'\
	} || {\
	rc-status default >/dev/null 2>&1 && echo 'openrc'\
	} || {\
	crontab -l >/dev/null 2>&1 && echo 'cron'\
	} || echo 'none')
LITELOGSHDIR=$(LITELOGDIR)/sh

MODULEDIR=$(LITELOGSHDIR)/$(MODULE)
MODULELOGDIR=$(LOGDIR)/$(MODULE)
MODULE_FILES=$(wildcard *.sh *functions)
SYSTEMD_FILES=$(wildcard *.service *.timer *.path)
UDEV_FILES=$(wildcard *.rules)

all:
	# try make install

install-base: /etc/litelog $(LITELOGSHDIR)/functions $(LOGDIR)

install-module: install-base
	mkdir -p "$(MODULEDIR)"
	mkdir -p "$(MODULELOGDIR)"
	-cp -va $(MODULE_FILES) "$(MODULEDIR)"
	-cp -va $(SYSTEMD_FILES) /lib/systemd/system
	-systemctl daemon-reload
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

