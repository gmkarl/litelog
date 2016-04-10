MODULE=git
SYSTEMD_START=litelog-sh-git-commit.path litelog-sh-git-commit.timer
include ../common.mk

install: install-module ${LOGDIR}/.git ${LOGDIR}/.gitignore

%/.git:
	-mkdir -p "$*"
	cd "$*"; if ! git status > /dev/null 2>&1; then su "$(LITELOGUSER)" -c 'git init "$*"'; fi

%/.gitignore: %/ /etc/litelog
	echo '.*_lock' > $@
	. /etc/litelog; . $$LITELOGDIR/sh/functions; get_logfilename_inprogress '*' '*' '*' '*' '*' '*' >> $@
	. /etc/litelog; . $$LITELOGDIR/sh/functions; get_logfilename_final '*' '*' '*' '*' raw '*' >> $@
	chown "$(LITELOGUSER)" $@
