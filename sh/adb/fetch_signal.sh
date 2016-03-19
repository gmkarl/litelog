#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIRSH"/adb/functions

android_fetchall messages signal /sdcard '^TextSecurePlaintextBackup\.xml$' xml delete
