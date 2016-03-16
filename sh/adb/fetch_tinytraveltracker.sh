#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIRSH"/adb/functions

android_fetchall gps tinytraveltracker /sdcard/android/data/com.rareventure.gps2/files '^gps\.db3$' sqlite3
