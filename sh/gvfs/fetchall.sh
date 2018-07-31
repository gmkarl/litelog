#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

for fetcher in "$LITELOGDIRSH"/gvfs/fetch_*
do
	sh "$fetcher" &
done
wait
echo 'gvfs fetch done'
