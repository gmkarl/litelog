#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

# beep if no incoming bluetooth packets
A="$(hciconfig|grep RX)"
while true
do
  sleep 1
  B="$(hciconfig|grep RX)"
  if [ "$A" == "$B" ]
  then
    beep
    hciconfig
  fi
  A="$B"
done
