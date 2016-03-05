#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

cd "$LOGDIR"/video

# delete the raw file which contains the least information
# (compresses to the smallest size)
min=$TIGHT_SPACE_BYTES
best_file=""
for raw_file in *_raw.mkv
do
  raw_pfx="${raw_file%_raw.mkv}"
  compressed_size=$(size_of "${raw_pfx}"_*_*.mkv)
  if test $compressed_size -lt $min
  then
    min=$compressed_size
    best_file="$raw_file"
  fi
done
if test -z "$best_file"
then
  echo "Couldn't pick a file to delete !!"
else
  rm -f "$best_file"
  echo "Deleted '$best_file'"
fi
