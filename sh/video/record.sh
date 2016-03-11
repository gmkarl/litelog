#!/bin/sh

. /etc/litelog

# LITELOGDIR defaults to /usr/lib/litelog
. "$LITELOGDIR"/sh/functions

# see: $LITELOGDIR/sh/functions
while ! ensure_space_free
do
	echo "Space filled on $LOGDIR ... will try again in an hour."

	if test -n "$FAKE_RECORD"
	then
		fake_record $((60*60))
	else
		sleep $((60*60))
	fi
done

# see: $LITELOGDIR/sh/video/ffmpeg_functions
exec_record v4l2 "$1" "${1##*/}"
