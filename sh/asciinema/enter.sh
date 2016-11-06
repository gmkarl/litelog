#!/bin/sh

. /etc/litelog

. "$LITELOGDIR"/sh/functions

if ! test "$_LITELOG_SH_ASCIINEMA" = 1
then
	export _LITELOG_SH_ASCIINEMA=1
	
	exec asciinema rec -c "$(readlink -f /proc/$$/exe)" -q "$LOGDIR/$(get_logfilename_inprogress terminal "$(format_date now)" "$HOSTNAME" "$TERM$$" "raw" json)"
fi
