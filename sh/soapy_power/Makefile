MODULE=soapy_power
SYSTEMD_START=litelog-sh-soapy_power-compress.path
include ../common.mk

dep:
		# Detecting soapy_power
		soapy_power --version >/dev/null

install: install-module

uninstall: uninstall-module
