#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

cd "$LOGDIR"

DAEMONPID="$(cat "$(git rev-parse --git-dir)"/annex/daemon.pid)"

if ! ps "$DAEMONPID" > /dev/null
then
  # daemon not running
  
  # move files to a remote repo
  if test -n "$GITANNEX_MOVETO"
  then
    git annex move --all --to="$GITANNEX_MOVETO"
  fi
fi

# TODO: if size still tight, pack git history in the repo, then move git history to some remote repo

#git annex unused --time-limit=20s
#git annex drop --trust-glacier --unused --force --time-limit=20s
#git annex drop --auto --numcopies 1 --time-limit=20s
