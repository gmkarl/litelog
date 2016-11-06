#!/bin/sh

# Attemps to compress json logs

. /etc/litelog
. "$LITELOGDIR"/sh/functions

cd "$LOGDIR"
(
	flock -n 9 || exit 1
	for uncompressed in $(get_logfilename_inprogress terminal '*' '*' '*' raw json)
	do
		# if no uncompressed files exist
		test -e "$uncompressed" || continue

		# do not process open files
		fuser -s "$uncompressed" && continue

		if ! test -s "$uncompressed"
		then
			echo "deleting zero sized file: $uncompressed"
			rm "$uncompressed"
			continue
		fi

		# see: sh/functionsn and sh/video/free_space.sh
		ensure_space_free

		# compress file
		get_logfilename_components "$uncompressed"
		compressed="$rPREFIX$(get_logfilename_inprogress "$rMODULE" "$rDATE" "$rHOSTNAME" "$rSOURCE" "${TEXT_CODEC##*/}" "$rEXTENSION"."$TEXT_CODEC_EXT")"
		$TEXT_CODEC $TEXT_CODEC_ARG < "$uncompressed" > "$compressed" &&
		
		# verify correct
		test "$("$TEXT_CODEC" $TEXT_CODEC_ARG -d < "$compressed" | "$HASH")" = "$("$HASH" < "$uncompressed")" &&

		# final
		finalize_inprogress_logfile "$compressed" &&
		rm "$uncompressed" ||

		# if processing fails
		rm "$compressed"
	done
) 9>.compress_video_lock
