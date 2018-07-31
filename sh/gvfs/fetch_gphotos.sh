
. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIRSH"/gvfs/functions

gvfs_mount_info | while read m1 m2 m3 m4 m5 m6 m7 m8 m9
do
	if test "$m2" = "gphoto2"
	then
		device="$(gvfs_device "$m1" "$m2" "$m3" "$m4" "$m5" "$m6" "$m7" "$m8" "$m9")"
		find "$m1" | sed -ne 's!^.*/\([^/]*\)/\([^_]*\)_\(....\)\(..\)\(..\)[_-]\(..\)\(..\)\(..\)[0-9]*\.\([a-z0-9]*\)$!\1 \2 \9 \3-\4-\5 \6:\7:\8 &!p' | while read subdir label ext day time path
		do
			timestamp=$(($(date -d "$day $time" +%s)))
			if test "$ext" = "jpg"
			then
				compression="jpeg"
				module="image"
			elif test "$ext" = "png"
			then
				compression="png"
				module="image"
				subdir="$label"
			elif test "$ext" = "mp4"
			then
				compression="mp4"
				module="video"
			else
				continue
			fi
			gvfs_fetch "$module" "$device" "$subdir" "$timestamp" "$path" "$compression" delete
		done
	fi
done

