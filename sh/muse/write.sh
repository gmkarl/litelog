#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

MUSE_DIR="${MUSE_DIR:-/opt/Muse}"

FILE="$LOGDIR/$(get_logfilename_inprogress bio "$(format_date now)" "${MAC//:/}" muse raw muse)"

"$MUSE_DIR"/muse-player -l -F "$FILE"
