MODULE=git
include ../common.mk

install: install-module ${LOGDIR}/.git ${LOGDIR}/.gitignore
	-systemctl start litelog-sh-git-commit.path
	-systemctl start litelog-sh-git-commit.timer

%/.git:
	-mkdir -p "$*"
	git init "$*"

%/.gitignore: %/
	echo '.*_lock' > $@
	echo '*_unprocessed.*' >> $@
	echo '*_raw.*' >> $@
	echo '*.incomplete' >> $@
	echo 'tmp/**' >> $@
	
