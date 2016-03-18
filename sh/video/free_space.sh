#!/bin/sh

. /etc/litelog
. "$LITELOGDIR"/sh/functions

cd "$LOGDIR"

# delete the raw file which contains the least information
# (compressed to the smallest size)
min=$TIGHT_SPACE_BYTES
best_file=""
for raw_file in $(get_logfilename_final video '*' '*' '*' raw '*')
do
  get_logfilename_components "$raw_file"
  compressionsGlob=$(get_logfilename_final "$rMODULE" "$rDATE" "$rHOSTNAME" "$rSOURCE" '*' "$rEXTENSION")
  for compressedFile in $compressionsGlob
  do
    if test "$compressedFile" == "$raw_file"; then continue; fi
    compressed_size=$(size_of "$compressedFile")
    if test $compressed_size -lt $min
    then
      min=$compressed_size
      best_file="$raw_file"
    fi
  done
done
if test -z "$best_file"
then
  echo "Couldn't pick a file to delete !!"
  false
else
  rm -f "$best_file"
  echo "Deleted '$best_file'"
fi
