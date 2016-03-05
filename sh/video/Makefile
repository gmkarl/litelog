MODULE=video
MODULEDIR=$(LITELOGSHDIR)/$(MODULE)
MODULELOGDIR=$(LOGDIR)/$(MODULE)
MODULE_FILES=$(wildcard *.sh *functions)
SYSTEMD_FILES=$(wildcard *.service)
UDEV_FILES=$(wildcard *.rules)

install:
	mkdir -p "$(MODULEDIR)"
	mkdir -p "$(MODULELOGDIR)"
	$(INSTALL) $(MODULE_FILES) "$(MODULEDIR)"
	$(INSTALL) $(SYSTEMD_FILES) /etc/systemd/system
	$(INSTALL) $(UDEV_FILES) /etc/udev/rules.d

uninstall:
	-cd /etc/systemd/system && rm $(SYSTEMD_FILES)
	-cd /etc/udev/rules.d && rm $(UDEV_FILES)
	-rm -rf "$(MODULEDIR)"
