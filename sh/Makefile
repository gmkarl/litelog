export LOGDIR=/var/lib/litelog
LITELOGDIR=/usr/lib/litelog
export LITELOGSHDIR=$(LITELOGDIR)/sh

export INSTALL=cp -va

install:
	if ! test -e /etc/litelog; then\
		echo LITELOGDIR='"$(LITELOGDIR)"' > /etc/litelog;\
		echo LOGDIR='"$(LOGDIR)"' >> /etc/litelog;\
		echo HOSTNAME='"$(shell hostname)"' >> /etc/litelog;\
	fi
	mkdir -p "$(LITELOGSHDIR)"
	cp -v *functions "$(LITELOGSHDIR)"
	mkdir -p "$(LOGDIR)"
	cd "${LOGDIR}"; if ! test -d .git; then git init; fi
	$(MAKE) -C video install

uninstall:
	-rm -rf "$(LITELOGSHDIR)"
	$(MAKE) -C video uninstall
