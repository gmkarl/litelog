#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

cd "$LOGDIR"
flock .git_annex_lock -c 'git annex sync --content --trust-glacier'
git annex unused --time-limit=20s
git annex drop --trust-glacier --unused --force --time-limit=20s
git annex drop --auto --numcopies 1 --time-limit=20s
