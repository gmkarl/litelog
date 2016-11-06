# absolute path of litelog/sh source tree
TOPDIR := $(dir $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))

# configurable
LOGDIR=/var/lib/litelog
LITELOGDIR=/usr/lib/litelog
LITELOGUSER=root

# detects and evaluates to one of systemd, upstart, sysvinit, cron, or none, in that order
SYSTEMD_SYSTEM_PATH=$(wildcard /usr/lib/systemd/system /lib/systemd/system)
SERVICEMANAGER=$(firstword $(filter $(wildcard *) none,\
$(shell test -w $(SYSTEMD_SYSTEM_PATH)d && systemctl list-units >/dev/null 2>&1 && echo 'systemd')\
$(shell test -w /etc/init && echo 'upstart')\
$(shell test -w /etc/init.d && echo 'sysvinit')\
$(shell crontab -l >/dev/null 2>&1 && echo 'cron')\
none))
LITELOGSHDIR=$(LITELOGDIR)/sh

MODULEDIR=$(LITELOGSHDIR)/$(MODULE)
MODULE_FILES=$(wildcard *.sh *functions)
SYSTEMD_FILES=$(wildcard systemd/*.service systemd/*.timer systemd/*.path)
SYSTEMD_UDEV_FILES=$(wildcard systemd/*.rules)
SYSTEMD_MODULE_FILES=$(wildcard systemd/*.sh systemd/*functions)
SYSVINIT_UDEV_FILES=$(wildcard sysvinit/*.rules)
SYSVINIT_MODULE_FILES=$(wildcard sysvinit/*.sh sysvinit/*functions)
SYSVINIT_FILES=$(filter-out $(SYSVINIT_UDEV_FILES) $(SYSVINIT_MODULE_FILES), $(wildcard sysvinit/*))

all:
	#
	# Install with:
	#
	# adduser litelog --home=/usr/lib/litelog
	# make install LOGDIR=/usr/lib/litelog LITELOGUSER=litelog
	#

install-base: /etc/litelog $(LITELOGSHDIR)/functions $(LOGDIR)

install-module: dep install-base install-module-files install-servicemanager-$(SERVICEMANAGER)

dep:

install-module-files: $(MODULE_FILES)
	-mkdir -p "$(MODULEDIR)"
	-cp -va $(MODULE_FILES) "$(MODULEDIR)"

install-servicemanager-systemd: install-module-files $(SYSTEMD_FILES) $(SYSTEMD_UDEV_FILES) $(SYSTEMD_MODULE_FILES)
	-mkdir -p "$(MODULEDIR)/systemd"
	-cp -va $(SYSTEMD_MODULE_FILES) "$(MODULEDIR)/systemd"
	cp -va $(SYSTEMD_FILES) "$(SYSTEMD_SYSTEM_PATH)"
	-systemctl start litelog-sh-systemd-confsync.service
	systemctl daemon-reload
	-cp -va $(SYSTEMD_UDEV_FILES) /etc/udev/rules.d && systemctl restart systemd-udevd
	for svc in $(SYSTEMD_START); do systemctl enable "$$svc"; systemctl restart "$$svc" || systemctl start "$$svc"; done

install-servicemanager-sysvinit:
	-mkdir -p "$(MODULEDIR)/sysvinit"
	-cp -va $(SYSVINIT_MODULE_FILES) "$(MODULEDIR)/sysvinit"
	cp -va $(SYSVINIT_FILES) /etc/init.d
	-cp -va $(SYSVINIT_UDEV_FILES) /etc/udev/rules.d && /etc/init.d/udev reload
	for svc in $(SYSVINIT_START); do rc-update add "$$svc"; /etc/init.d/"$$svc" restart || /etc/init.d/"$$svc"; done

install-servicemanager-upstart:
	# IMPLEMENT IF NEEDED

install-servicemanager-cron:
	# IMPLEMENT IF NEEDED

install-servicemanager-none:

uninstall-module: uninstall-servicemanager-$(SERVICEMANAGER)
	-rm -rf "$(MODULEDIR)"

uninstall-servicemanager-systemd:
	cd "$(SYSTEMD_SYSTEM_PATH)" && rm $(SYSTEMD_FILES:systemd/%=%)
	-cd /etc/udev/rules.d && rm $(SYSTEMD_UDEV_FILES:systemd/%=%)

uninstall-servicemanager-sysvinit:
	cd /etc/init.d && rm $(SYSVINIT_FILES:sysvinit/%=%)
	-cd /etc/udev/rules.d && rm $(SYSVINIT_UDEV_FILES:sysvinit/%=%)

uninstall-servicemanager-upstart:
	# IMPLEMENT IF NEEDED

uninstall-servicemanager-cron:
	# IMPLEMENT IF NEEDED

uninstall-servicemanager-none:

/etc/litelog:
	grep "^$(LITELOGUSER):" /etc/passwd
	echo LITELOGUSER='"$(LITELOGUSER)"' > /etc/litelog
	echo LITELOGDIR='"$(LITELOGDIR)"' >> /etc/litelog
	echo LOGDIR='"$(LOGDIR)"' >> /etc/litelog
	echo HOSTNAME='"$(shell hostname)"' >> /etc/litelog

$(LITELOGSHDIR)/functions: $(TOPDIR)/*functions
	-mkdir -p "$(LITELOGSHDIR)"
	cp -v $(TOPDIR)/*functions "$(LITELOGSHDIR)"

$(LOGDIR):
	-mkdir -p "$(LOGDIR)"

