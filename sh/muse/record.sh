#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

MUSE_DIR="${MUSE_DIR:-/opt/Muse}"

MAC="$1"

export LD_LIBRARY_PATH="$MUSE_DIR":"$LD_LIBRARY_PATH"

"$MUSE_DIR"/muse-io --device "$MAC" --no-dsp --preset ae --osc-enable-dropped --osc-timestamp
