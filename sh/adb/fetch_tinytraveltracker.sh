#!/bin/sh

. /etc/litelog
"$LITELOGDIR"/sh/functions
"$LITELOGDIRSH"/adb/functions

PLAN:
[ ] don't forget to add beepme data
[ ] just store the sqlite3 file in tmp for now.  it'll get synced as a priority file for conversion
[ ] copy from fetch.sh a basic function to relatively-correctly take a file from a connected phone and archive it
[ ] non-sqlite3 files can be finalized
  [ ] beepme
  [ ] tinytraveltracker
  [ ] voice recorder
  [ ] muse
