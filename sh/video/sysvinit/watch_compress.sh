#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

while true
do
  "$LITELOGDIRSH"/video/compress.sh
  inotifywait -r -e close_write "$LOGDIR" >/dev/null 2>&1|| sleep 120
done
