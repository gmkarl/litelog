include common.mk

install:
	$(MAKE) -C $(SERVICEMANAGER) install
	$(MAKE) -C video install
	$(MAKE) -C git install
	$(MAKE) -C tight_space install

uninstall:
	$(MAKE) -C $(SERVICEMANAGER) uninstall
	$(MAKE) -C video uninstall
	$(MAKE) -C git uninstall
	$(MAKE) -C tight_space uninstall
	-rm -rf "$(LITELOGSHDIR)"
