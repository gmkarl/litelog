#!/bin/sh

if [ -e /etc/litelog ]
then
	. /etc/litelog
	. "$LITELOGDIR"/sh/functions
fi

MUSE_DIR="${MUSE_DIR:-/usr/local/Muse}"

MAC="$1"

export LD_LIBRARY_PATH="$MUSE_DIR":"$LD_LIBRARY_PATH"

"$MUSE_DIR"/muse-io --device "$MAC" --no-dsp --preset ae --osc-enable-dropped --osc-timestamp
