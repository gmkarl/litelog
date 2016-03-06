#!/bin/sh

. /etc/litelog

# LITELOGDIR defaults to /var/lib/litelog
. "$LITELOGDIR"/sh/functions

# see: $LITELOGDIR/sh/functions
ensure_space_free &

# see: $LITELOGDIR/sh/video/ffmpeg_functions
exec_record v4l2 "$1" "${1##*/}"
