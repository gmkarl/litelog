#!/bin/sh

if test -n "$PS1" -a -z "$_LITELOG_SH_ASCIINEMA"
then
	. /etc/litelog

	. "$LITELOGDIR"/sh/functions

	export _LITELOG_SH_ASCIINEMA=1
	
	exec asciinema rec -c "$(readlink -f /proc/$$/exe)" -q "$LOGDIR/$(get_logfilename_inprogress terminal "$(format_date now)" "$HOSTNAME" "$TERM$$" "raw" json)"
fi
