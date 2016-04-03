#!/bin/sh

# Compresses written logfiles

. /etc/litelog
. "$LITELOGDIR"/sh/functions

cd "$LOGDIR"

while true
do
	for unprocessed in $(get_logfilename_inprogress rsyslog '*' '*' '*' raw txt)
	do
		# if no unprocessed files exist
		if ! test -e "$unprocessed"
		then
			# sleep until a file is written
			inotifywait -r -e close_write "$LOGDIR" >/dev/null 2>&1 || sleep 120
			continue
		fi

		# do not process open files
		fuser -s "$unprocessed" && continue

		if ! test -s "$unprocessed"
		then
			echo "deleting zero sized file: $unprocessed"
			rm "$unprocessed"
			continue
		fi	
		
		# see: sh/functions
		ensure_space_free

		# compress file
		get_logfilename_components "$unprocessed"
		compressed="$rPREFIX$(get_logfilename_inprogress "$rMODULE" "$rDATE" "$rHOSTNAME" "$rSOURCE" "${TEXT_CODEC##*/}" "$rEXTENSION"."$TEXT_CODEC_EXT")"
		"$TEXT_CODEC" $TEXT_CODEC_ARG< "$unprocessed" > "$compressed" &&
		
		# verify
		test "$("$TEXT_CODEC" $TEXT_CODEC_ARG -d < "$compressed" | "$HASH")" == "$("$HASH" < "$uncompressed")" &&

		# final
		finalize_inprogress_logfile "$compressed" &&
		rm "$uncompressed" ||

		# if processing fails
		rm "$compressed"
	done
done
