#!/bin/sh

. /etc/litelog

. "$LITELOGDIR"/sh/functions

exec asciinema rec -c "$*" -q "$LOGDIR/$(get_logfilename_inprogress terminal "$(format_date now)" "$HOSTNAME" "$TERM$$" "raw" json)"
