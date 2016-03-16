#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIRSH"/adb/functions

android_fetchall audio voicerecorder /sdcard/Sounds '^Voice ' unknown delete | while read filename
do
  finalize_inprogress_logfile "$filename"
done

