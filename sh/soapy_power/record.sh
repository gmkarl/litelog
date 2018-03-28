#!/bin/sh

. /etc/litelog

# LITELOGDIR defaults ot /usr/lib/litelog
. "$LITELOGDIR"/sh/functions

driverstr="$1"
scrubbedDEV="$(echo "$driverstr" | sed 's/[^a-zA-Z0-9=]/-/g')"
scrubbedFMT="$(echo "$SOAPY_POWER_FMT" | sed 's/_/-/g')"

output="$LOGDIR/$(get_logfilename_inprogress sdr "$(format_date now)" "$HOSTNAME" "soapypower-$scrubbedDEV" "raw" "$scrubbedFMT")"

exec soapy_power $SOAPY_POWER_ARGS -O "$output" -F "$SOAPY_POWER_FMT" -e "$ROTATE_SECONDS" -d "$driverstr"
