
. /etc/litelog
. "$LITELOGDIR"/sh/functions
. "$LITELOGDIRSH"/gvfs/functions

gvfs_mount_info | while read m1 m2 m3 m4 m5 m6 m7 m8 m9
do
	if test "$m2" = "gphoto2"
	then
		device="$(gvfs_device "$m1" "$m2" "$m3" "$m4" "$m5" "$m6" "$m7" "$m8" "$m9")"
		find "$m1" | sed -ne 's!^.*/\([^/]*\)/IMG_\(....\)\(..\)\(..\)_\(..\)\(..\)\(..\)[0-9]*\.\([a-z0-9]*\)$!\1 \8 \2-\3-\4 \5:\6:\7 &!p' | while read subdir ext day time path
		do
			timestamp=$(($(date -d "$day $time" +%s)))
			if test "$ext" = "jpg"
			then
				compression="jpeg"
			else
				continue
			fi
			gvfs_fetch image "$device" "$subdir" "$timestamp" "$path" "$compression"
		done
	fi
done

