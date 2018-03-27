#!/bin/sh

. /etc/litelog

# LITELOGDIR defaults ot /usr/lib/litelog
. "$LITELOGDIR"/sh/functions

driverstr="$1"
scrubbed="$(echo "$driverstr" | sed 's/[^a-zA-Z0-9=]/-/g')"

output="$LOGDIR/$(get_logfilename_inprogress soapy_power "$(format_date now)" "$HOSTNAME" "$scrubbed" "raw" "$SOAPY_POWER_FMT")"

exec soapy_power "$SOAPY_POWER_ARGS" -O "$output" -F "$SOAPY_POWER_FMT" -e "$ROTATE_SECONDS" -d "$driverstr"
