MODULE=asciinema
SYSTEMD_START=litelog-sh-asciinema-compress.path
include ../common.mk

dep:
	## Detecting asciinema to record bash terminal sessions
	asciinema rec -h | grep filename >/dev/null
	

SCRIPT_INSTALL_PATH=/etc/profile.d/00-litelog-sh-asciinema-enter.sh

install: install-module
	ln -sf $(MODULEDIR)/enter.sh "$(SCRIPT_INSTALL_PATH)"
	echo '. "$(SCRIPT_INSTALL_PATH)"' >> /etc/bash.bashrc

uninstall: uninstall-module
	-rm /etc/profile.d/00-litelog-sh-asciinema-enter.sh
	sed -i '\!^. "$(SCRIPT_INSTALL_PATH)"$$!d' /etc/bash.bashrc
