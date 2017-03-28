#!/bin/sh

# Attempts to encode all unprocessed video

# TODO uncomment and implement gstreamer backend

# . /etc/litelog
# . "$LITELOGDIR"/sh/functions
# 
# cd "$LOGDIR"
# (
# 	flock -n 9 || exit 1
# 	for unprocessed in $(get_logfilename_inprogress video '*' '*' '*' raw '*')
# 	do
# 		# if no unprocessed files exist
# 		test -e "$unprocessed" || continue
# 
# 		# do not process open files
# 		fuser -s "$unprocessed" && continue
# 
# 		if ! test -s "$unprocessed"
# 		then
# 			echo "deleting zero sized file: $unprocessed"
# 			rm "$unprocessed"
# 			continue
# 		fi	
# 
# 		# see: sh/functions and sh/video/free_space.sh
# 		ensure_space_free
# 
# 		# compress file
# 		# see: sh/video/ffmpeg_functions
# 		compress "$unprocessed" &&
# 
# 		# verify full duration encoded (within 220 ms)
# 		duration_is_same_epsilon "$unprocessed" "$rCOMPRESSED" 220 &&
# 
# 		# mark final
# 		finalize_inprogress_logfile "$rCOMPRESSED" &&
# 		finalize_inprogress_logfile "$unprocessed" ||
# 
# 		# if processing fails ('||' above)
# 		rm "$rCOMPRESSED"
# 	done
# ) 9>.compress_video_lock
