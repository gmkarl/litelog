MODULE=git
include ../common.mk

install: install-module ${LOGDIR}/.git ${LOGDIR}/.gitignore

%/.git: %/
	git init "$*"

%/.gitignore: %/
	echo '.*_lock' > $@
	echo '*_unprocessed.*' >> $@
	echo '*_raw.*' >> $@
	
