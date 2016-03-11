MODULE=git
SYSTEMD_START=litelog-sh-git-commit.path litelog-sh-git-commit.timer
include ../common.mk

install: install-module ${LOGDIR}/.git ${LOGDIR}/.gitignore

%/.git:
	-mkdir -p "$*"
	git init "$*"

%/.gitignore: %/
	echo '.*_lock' > $@
	echo '*_unprocessed.*' >> $@
	echo '*_raw.*' >> $@
	echo '*.incomplete' >> $@
	echo 'tmp/**' >> $@
	
