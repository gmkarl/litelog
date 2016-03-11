# absolute path of litelog/sh source tree
TOPDIR := $(dir $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))

# configurable
LOGDIR=/var/lib/litelog
LITELOGDIR=/usr/lib/litelog

# detects and evaluates to one of systemd, upstart, sysvinit, cron, or none, in that order
SERVICEMANAGER=$(firstword $(filter $(wildcard *) none,\
$(shell test -w /lib/systemd && echo 'systemd')\
$(shell test -w /etc/init && echo 'upstart')\
$(shell test -w /etc/init.d && echo 'sysvinit')\
$(shell crontab -l >/dev/null 2>&1 && echo 'cron')\
none))
LITELOGSHDIR=$(LITELOGDIR)/sh

MODULEDIR=$(LITELOGSHDIR)/$(MODULE)
MODULELOGDIR=$(LOGDIR)/$(MODULE)
MODULE_FILES=$(wildcard *.sh *functions)
SYSTEMD_FILES=$(wildcard systemd/*.service systemd/*.timer systemd/*.path)
SYSTEMD_UDEV_FILES=$(wildcard systemd/*.rules)
SYSTEMD_MODULE_FILES=$(wildcard *.sh *functions)

all:
	# try make install

install-base: /etc/litelog $(LITELOGSHDIR)/functions $(LOGDIR)

install-module: install-base install-module-files install-servicemanager-$(SERVICEMANAGER)

install-module-files: $(MODULE_FILES)
	mkdir -p "$(MODULEDIR)"
	mkdir -p "$(MODULELOGDIR)"
	-cp -va $(MODULE_FILES) "$(MODULEDIR)"

install-servicemanager-systemd: install-module-files $(SYSTEMD_FILES) $(SYSTEMD_UDEV_FILES) $(SYSTEMD_MODULE_FILES)
	mkdir -p "$(MODULEDIR)/systemd"
	-cp -va $(SYSTEMD_MODULE_FILES) "$(MODULEDIR)/systemd"
	cp -va $(SYSTEMD_FILES) /lib/systemd/system
	systemctl daemon-reload
	-cp -va $(SYSTEMD_UDEV_FILES) /etc/udev/rules.d
	for svc in $(SYSTEMD_START); do systemctl start "$svc"; done

install-servicemanager-openrc:

install-servicemanager-cron:

install-servicemanager-none:

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

