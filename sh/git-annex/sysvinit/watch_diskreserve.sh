#!/bin/sh

while true
do
  (
    . /etc/litelog
    . "$LITELOGDIR"/sh/functions
    cd "$LOGDIR"
    git config --unset-all annex.diskreserve
    git config --add annex.diskreserve "$((TIGHT_SPACE_BYTES))"
  )
  inotifywait -r -e close_write /etc/litelog >/dev/null 2>&1 || sleep 120
done
