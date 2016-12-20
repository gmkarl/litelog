#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

device="$1"
major=$((0x$(stat -c %t "$device")))
minor=$((0x$(stat -c %T "$device")))
serial="$(cat /sys/dev/char/$major:$minor/device/../../serial)"

file="$LOGDIR/$(get_logfilename_inprogress bio "$(format_date now)" "$serial" zeo raw dump)"

# The serial port is set at baud 38400, no parity, one stop bit.
stty -F "$device" 38400 -parenb -cstopb
cat "$device" > "$file"
