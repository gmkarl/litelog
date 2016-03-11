#!/bin/sh
. /etc/litelog
# LITELOGDIR defaults to /usr/lib/litelog
. "$LITELOGDIR"/sh/functions

if ! ensure_space_free
then
  recording_units=$(systemctl list-units --full |
    sed -ne 's/\(^litelog-sh-\S*record\S*\)\s.*\srunning.*$/\1/p')

  # stop all running record units
  for unit in $recording_units
  do
    systemctl stop $unit
  done

  # wait until space free
  while ! ensure_space_free
  do
    sleep 60
  done

  # start units again
  for unit in $recording_units
  do
    systemctl start $unit
  done
fi
