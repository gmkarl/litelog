#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIRSH"/adb/functions

android_fetchall bio muse /sdcard/Download '\.muse$' raw delete | while read filename
do
  finalize_inprogress_logfile "$filename"
done
