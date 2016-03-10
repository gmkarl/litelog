#!/bin/sh

# This script updates non-service unit files to have the correct configured paths.
# .service files are expected to use EnvironmentFile=/etc/litelog and not need this treatment
# called automatically when /etc/litelog changes

. /etc/litelog

# LITELOGDIR defaults to /var/lib/litelog
. "$LITELOGDIR"/sh/functions

for unitfile in /lib/systemd/system/litelog-*.path
do
	unitname="${unitfile##*/}"
	confdir=/etc/systemd/system/"$unitname".d
	mkdir -p "$confdir"

	# replace default paths with configured ones, generate configuration file for the unit
	sed -ne '/^\[Path\]/p; s!^\(Path.*=\)/var/lib/litelog!\1'"$LOGDIR"'!p; s!^\(Path.*=\)/usr/lib/litelog!\1'"$LITELOGDIR"'!p' "$unitfile" |
	while read line
	do
		# expand shell globs if relevant
		if echo "$line" | grep -q = && ! echo "$line" | grep -q Glob=
		then
			pfx="${line%=*}="
			sfx="${line##*=}"
			sh -c 'for entry in '"$sfx"'; do echo "'"$pfx"'$entry"; done'
		else
			echo "$line"
		fi
	done > "$confdir"/autogenerated-path.conf
done
