#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIRSH"/adb/functions

android_fetchall image photo /sdcard/DCIM/Camera '\.jpg$' jpeg delete |
while read filename
do
  finalize_inprogress_logfile "$filename"
done
