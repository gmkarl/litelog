#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIRSH"/adb/functions

android_fetchall audio callrecorder /sdcard/recordedCalls '.*' unknown delete | while read filename
do
  finalize_inprogress_logfile "$filename"
done
