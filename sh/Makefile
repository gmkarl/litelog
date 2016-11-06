include common.mk

install:
	$(MAKE) -C $(SERVICEMANAGER) install
	$(MAKE) -C video install
	$(MAKE) -C git install
	$(MAKE) -C tight_space install
	-$(MAKE) -C git-annex install
	-$(MAKE) -C asciinema install

uninstall:
	$(MAKE) -C $(SERVICEMANAGER) uninstall
	$(MAKE) -C video uninstall
	$(MAKE) -C git uninstall
	$(MAKE) -C tight_space uninstall
	-$(MAKE) -C git-annex uninstall
	-$(MAKE) -C asciinema uninstall
	-rm -rf "$(LITELOGSHDIR)"
