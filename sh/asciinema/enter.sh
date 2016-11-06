#!/bin/sh

if test -n "$PS1" -a -z "$ASCIINEMA_REC"
then
	. /etc/litelog

	. "$LITELOGDIR"/sh/functions
	
	exec asciinema rec -c "$(readlink -f /proc/$$/exe)" -q "$LOGDIR/$(get_logfilename_inprogress terminal "$(format_date now)" "$HOSTNAME" "$TERM$$" "raw" json)"
fi
