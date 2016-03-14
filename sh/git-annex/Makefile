MODULE=git-annex
SYSTEMD_START=litelog-sh-git_annex-watch.service litelog-sh-git_annex-sync.timer litelog-sh-git_annex-fsck.service litelog-sh-git_annex-diskreserve.path litelog-sh-git_annex-diskreserve.service
include ../common.mk

install: install-module ${LOGDIR}/.git/annex ${LOGDIR}/.gitattributes

%/.git:
	-mkdir -p "$*"
	cd "$*"; if ! git status > /dev/null 2>&1; then git init "$*"; fi

%/.git/annex: %/.git %/.gitignore
	cd "$*"; if ! git annex status > /dev/null 2>&1; then git annex init; fi
	. /etc/litelog; . $$LITELOGDIR/sh/functions; sed -nie "\!$$(get_logfilename_inprogress '*' '*' '*' '*' '*' '*')!!p; \!$$(get_logfilename_final '*' '*' '*' '*' '*' '*')!!p" $*/.gitignore

%/.gitattributes:
	echo '* annex.numcopies=2' > $@
	echo '* annex.backends=SHA512' >> $@
	echo '* annex.largefiles=2kb' >> $@
	. /etc/litelog; . $$LITELOGDIR/sh/functions; get_logfilename_final '*' '*' '*' '*' raw '* annex.numcopies=0' >> $@
	. /etc/litelog; . $$LITELOGDIR/sh/functions; get_logfilename_inprogress '*' '*' '*' '*' '*' '* annex.expireunused=1d'

%/.gitignore: %/
	echo '.*_lock' > $@
