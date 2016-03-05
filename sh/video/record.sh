#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

/bin/sh "$LITELOGDIR"/video/compress.sh &

path="$*"

exec_record v4l2 "$path" "$LOGDIR"/video/"$(date -Is)_${HOSTNAME}_${path##*/}_unprocessed.mkv"
