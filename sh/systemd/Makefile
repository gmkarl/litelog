MODULE=systemd
SYSTEMD_START=litelog-sh-systemd-confsync.path
include ../common.mk

install: install-module

install-servicemanager-systemd: adjust-systemd-path

adjust-systemd-path:
	sed -i 's!/lib/systemd/system!$(SYSTEMD_SYSTEM_PATH)!g' "$(MODULEDIR)"/confsync.sh

uninstall: uninstall-module
