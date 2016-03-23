#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

for fetcher in "$LITELOGDIRSH"/adb/fetch_*
do
  sh "$fetcher" &
done
wait
echo 'adb fetch done'
