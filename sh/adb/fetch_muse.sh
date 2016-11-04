#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIRSH"/adb/functions

android_fetchall bio muse /sdcard/Download '^musedata_' raw delete
android_fetchall bio muse /sdcard/Download '^museMonitor_' raw delete
