#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

cd "$LOGDIR"/video
(
	flock -n 9 || exit 1
	for unprocessed in *_unprocessed.mkv
	do
		if ! test -s "$unprocessed"
		then
			echo "deleting zero sized file: $unprocessed"
			rm "$unprocessed"
			continue
		fi	

		ensure_space_free

		# compress a file
		pfx=${unprocessed%_unprocessed.mkv}
		cmprssd="$pfx"_${ACODEC}_${VCODEC}.mkv
		compress "$unprocessed" "$cmprssd" || continue
		duration_is_same_epsilon "$unprocessed" "$cmprssd" 54 || continue
		git add "$cmprssd"
		git commit -m "$cmprssd"
		touch "$cmprssd" -r "$unprocessed"
		mv "$unprocessed" "$pfx"_raw.mkv
	done
) 9>.compress_video_lock
