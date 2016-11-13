#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIRSH"/adb/functions

android_fetchall video adb /sdcard/DCIM/Camera '\.mp4$' mp4 delete |
while read filename
do
  finalize_inprogress_logfile "$filename"
done
