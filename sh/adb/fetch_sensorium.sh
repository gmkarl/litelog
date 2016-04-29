#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIR"/sh/adb/functions

for sensor in Battery Bluetooth DeviceInfo GPSLocation NetworkLocation Radio SIM WifiConnection Wifi
do
  android_fetchall adb sensorium-"$sensor" /sdcard/sensorium "${sensor}"'Sensor\.json\.[0-9]*' json delete
done
