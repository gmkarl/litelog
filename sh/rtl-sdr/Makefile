MODULE=rtl-sdr

include ../common.mk

LDLIBS=-lrtlsdr
all: rtl_serial2id
install: install-module rtl_serial2id
	cp -va rtl_serial2id "$(MODULEDIR)"

uninstall: uninstall-module
