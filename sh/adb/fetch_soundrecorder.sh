#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIRSH"/adb/functions

android_fetchall audio soundrecorder /sdcard/SoundRecorder '^My Recording ' unknown delete | while read filename
do
  finalize_inprogress_logfile "$filename"
done

