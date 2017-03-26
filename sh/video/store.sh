#!/bin/sh

. /etc/litelog

# LITELOGDIR defaults to /usr/lib/litelog
. "$LITELOGDIR"/sh/functions

# wait_for_space_free defined in $LITELOGDIR/sh/functions
wait_for_space_free 
while ! ensure_space_free
do
	echo "Space filled on $LOGDIR ... will try again in an hour."

done

exec_store "${1##*/}"
