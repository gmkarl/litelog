#!/bin/sh

if test -n "$PS1" -a -z "$ASCIINEMA_REC"
then
	. /etc/litelog

	. "$LITELOGDIR"/sh/functions

	command="$(readlink -f /proc/$$/exe)"
	output="$LOGDIR/$(get_logfilename_inprogress terminal "$(format_date now)" "$HOSTNAME" "$TERM$$" "raw" json)"

	if touch "$output"
	then
		rm "$output"
		exec asciinema rec -c "$command" -q "$output"
	fi
fi
