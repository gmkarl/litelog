#!/bin/sh

. /etc/litelog

# LITELOGDIR defaults to /usr/lib/litelog
. "$LITELOGDIR"/sh/functions

# wait_for_space_free defined in $LITELOGDIR/sh/functions
if test -n "$FAKE_RECORD"
then
	wait_for_space_free fake_record $((60*60))
else
	wait_for_space_free
fi
wait_for_space_free 
while ! ensure_space_free
do
	echo "Space filled on $LOGDIR ... will try again in an hour."

done

# see: $LITELOGDIR/sh/video/ffmpeg_functions
exec_record v4l2 "$1" "${1##*/}"
