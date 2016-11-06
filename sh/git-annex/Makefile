MODULE=git-annex
SYSTEMD_START=litelog-sh-git_annex-webapp.service litelog-sh-git_annex-diskreserve.path litelog-sh-git_annex-diskreserve.service
SYSVINIT_START=litelog-sh-git_annex-webapp litelog-sh-git_annex-diskreserve
include ../common.mk

dep:
	# Detecting git-annex for content tracking
	git-annex version >/dev/null

install: install-module ${LOGDIR}/.git/annex ${LOGDIR}/.gitattributes
	-systemctl disable litelog-sh-git-commit.path
	-systemctl disable litelog-sh-git-commit.timer

PRECIOUS: ${LOGDIR}/.gitattributes ${LOGDIR}/.gitignore

%/.git:
	-su "$(LITELOGUSER)" -c 'mkdir -p "$*"'
	cd "$*"; if ! git status > /dev/null 2>&1; then su "$(LITELOGUSER)" -c 'git init "$*"'; fi

%/.git/annex: %/.git %/.gitignore
	cd "$*"; if ! git annex status > /dev/null 2>&1; then su "$(LITELOGUSER)" -c 'git annex init'; fi
	. /etc/litelog; . $$LITELOGDIR/sh/functions; sed -nie "\!$$(get_logfilename_inprogress '*' '*' '*' '*' '*' '*')!!p; \!$$(get_logfilename_final '*' '*' '*' '*' '*' '*')!!p" $*/.gitignore

%/.gitattributes:
	echo '* annex.numcopies=2' > $@
	echo '* annex.backends=SHA3_512' >> $@
	. /etc/litelog; . $$LITELOGDIR/sh/functions; get_logfilename_final '*' '*' '*' '*' raw '* annex.numcopies=0' >> $@
	. /etc/litelog; . $$LITELOGDIR/sh/functions; get_logfilename_inprogress '*' '*' '*' '*' '*' '* annex.expireunused=1d annex.numcopies=2' >> $@
	chown "$(LITELOGUSER)" $@

%/.gitignore: %/
	echo '.*_lock' > $@
	chown "$(LITELOGUSER)" $@
