#!/bin/sh

# Usage: systemctl-serial.sh start|stop|status [serial]
# $serial taken from environment if not provided
# service itself uses index numbers rather than serial numbers

action="$1"
serial="${2:-$serial}"


. /etc/litelog
. "$LITELOGDIR"/sh/functions

index="$("$LITELOGDIR"/sh/rtl-sdr/rtl_serial2id --reassign "$serial")"
index=$((index))
exec /usr/bin/systemctl "$action" litelog-sh-rtl_sdr-record@"$index"

