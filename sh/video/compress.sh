#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

cd "$LOGDIR"/video
(
	flock -n 9 || exit 1
	for unprocessed in *_unprocessed.mkv
	do
		# compress a file
		pfx=${unprocessed%_unprocessed.mkv}
		cmprssd="$pfx"_${ACODEC}_${VCODEC}.mkv
		compress "$unprocessed" "$cmprssd" || continue
		duration_is_same_epsilon "$unprocessed" "$cmprssd" 54 || continue
		git add "$cmprssd"
		git commit -m "$cmprssd"
		touch "$cmprssd" -r "$unprocessed"
		mv "$unprocessed" "$pfx"_raw.mkv

		# make sure space is kept free (deletes already-compressed files)
		while space_is_tight
		do
			echo "Drive space is getting tight, deleting a raw video file ..."
			/bin/sh "$LITELOGDIR"/video/free_space.sh
		done
	done
) 9>.compress_video_lock
