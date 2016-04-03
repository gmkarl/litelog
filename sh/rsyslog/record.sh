#!/in/sh
. /etc/litelog

# LITELOGDIR defaults to /usr/lib/litelog
. "$LITELOGDIR"/sh/functions

severity="$1"

do
	start_time="$(date +%s)"

	while read line < "$LOGDIR"/.rsyslog-"$severity"
	do
		echo "$line"
		
		if test $(($(date +%s) - start_tim)) -ge $((ROTATE_SECONDS))
		then
			break
		fi
	done > "$(get_logfilename_inprogress rsyslog $(format_date now) "$HOSTNAME" "$severity" "raw" txt)"
done
