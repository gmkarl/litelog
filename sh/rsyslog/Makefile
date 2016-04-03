MODULE=rsyslog
SEVERITIES=emerg alert crit err warning notice info debug
SYSTEMD_START=$(SEVERITIES:%=litelog-sh-rsyslog-record@%)
include ../common.mk

install: install-module $(SEVERITIES:%=$(LOGDIR)/.$(MODULE)-%)

$(LOGDIR)/.$(MODULE)-%:
	mkfifo "$@"
	

uninstall: uninstall-module
