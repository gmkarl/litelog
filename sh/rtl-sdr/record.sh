#!/bin/sh
. /etc/litelog
. "$LITELOGDIR"/sh/functions

dev_index="$1"
dev_serial="$(rtl_eeprom -d "$dev_index" 2>&1|sed -ne 's/Serial number:\t*\(.*\)/\1/p')"

# first try RTLPOWER_ARGS_[serial] then just RTLPOWER_ARGS
eval "RTLPOWER_ARGS=\"\${RTLPOWER_ARGS_${dev_serial}:-\$RTLPOWER_ARGS}\""
RTLPOWER_ARGS="${RTLPOWER_ARGS:- -f 0:1700M:250k -g 50 -i 45s}"


date_now="$(format_date now)"
export RTL_LOGFILE="$LOGDIR/$(get_logfilename_inprogress rtlsdr "$date_now" "$HOSTNAME" "$dev_serial"-logfile "raw" "raw")"
CONSOLE_LOGFILE="$LOGDIR/$(get_logfilename_inprogress rtlsdr "$date_now" "$HOSTNAME" "$dev_serial"-console "raw" "txt")"
POWER_LOGFILE="$LOGDIR/$(get_logfilename_inprogress rtlsdr "$date_now" "$HOSTNAME" "$dev_serial"-power "raw" "csv")"
RTLPOWER_ARGS="rtl_power -d $dev_index -e $((ROTATE_SECONDS)) $RTLPOWER_ARGS"
echo "> $RTLPOWER_ARGS $POWER_LOGFILE"
exec $RTLPOWER_ARGS "$POWER_LOGFILE"
