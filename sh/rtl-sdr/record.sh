#!/bin/sh
. /etc/litelog
. "$LITELOGDIR"/sh/functions

dev="$1"

date_now="$(format_date now)"
get_logfilename_inprogress rtlsdr "$(format_date now)" "$HOSTNAME" "${1##*/}"
# TODO finish but also these are usb devices !  they may not have a device file ?
