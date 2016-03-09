#!/bin/sh

# Attempts to encode all unprocessed video

. /etc/litelog
. "$LITELOGDIR"/sh/functions

cd "$LOGDIR"/video
(
	flock -n 9 || exit 1
	for unprocessed in *_unprocessed.mkv
	do
		# if no unprocessed files exist
		test -e "$unprocessed" || continue

		# do not process open files
		fuser -s "$unprocessed" && continue

		if ! test -s "$unprocessed"
		then
			echo "deleting zero sized file: $unprocessed"
			rm "$unprocessed"
			continue
		fi	

		# see: sh/functions and sh/video/free_space.sh
		ensure_space_free

		# compress file
		# see: sh/video/ffmpeg_functions
		compress "$unprocessed" ".incomplete"|| continue

		# verify full duration encoded (within 220 ms)
		duration_is_same_epsilon "$unprocessed" "$rCOMPRESSED".incomplete 220 || continue

		# copy timestamp and remove .incomplete suffix
		touch "$rCOMPRESSED".incomplete -r "$unprocessed" &&
		mv "$rCOMPRESSED".incomplete "$rCOMPRESSED" || continue

		# mark processed
		mv "$unprocessed" "${unprocessed%_unprocessed.mkv}"_raw.mkv
	done
) 9>.compress_video_lock
