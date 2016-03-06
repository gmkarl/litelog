include common.mk

install:
	$(MAKE) -C systemd install
	$(MAKE) -C video install
	$(MAKE) -C git install

uninstall:
	-rm -rf "$(LITELOGSHDIR)"
	$(MAKE) -C video uninstall
