include common.mk

install:
	$(MAKE) -C $(SERVICEMANAGER) install
	$(MAKE) -C video install
	$(MAKE) -C git install
	$(MAKE) -C tight_space install
	if git-annex version >/dev/null; then $(MAKE) -C git-annex install; fi

uninstall:
	$(MAKE) -C $(SERVICEMANAGER) uninstall
	$(MAKE) -C video uninstall
	$(MAKE) -C git uninstall
	$(MAKE) -C tight_space uninstall
	-$(MAKE) -C git-annex uninstall
	-rm -rf "$(LITELOGSHDIR)"
