#!/bin/sh

# This script updates unit files to match configuration to /etc/litelog.
# called automatically when /etc/litelog changes

. /etc/litelog

# LITELOGDIR defaults to /var/lib/litelog
. "$LITELOGDIR"/sh/functions

# Set user in .service files
for unitfile in /lib/systemd/system/litelog-sh-*.service
do
	grep -q '^User=' "$unitfile" && continue 
	unitname="${unitfile##*/}"
	confdir=/etc/systemd/system/"$unitname".d
	mkdir -p "$confdir"

	echo "[Service]" > "$confdir"/autogenerated-user.conf
	echo "User=$LITELOGUSER" >> "$confdir"/autogenerated-user.conf
done

# Expand pathnames in .path files. .service files are expected to use EnvironmentFile=/etc/litelog and not need this treatment
for unitfile in /lib/systemd/system/litelog-sh-*.path
do
	unitname="${unitfile##*/}"
	confdir=/etc/systemd/system/"$unitname".d
	mkdir -p "$confdir"

	# replace default paths with configured ones, generate configuration file for the unit
	sed -ne '/^\[Path\]/p; /^Path.*=/p; ' $unitfile |
		sed -e "s!LOGDIR!$LOGDIR!g; s!LITELOGDIR!$LITELOGDIR!g;" |
		while read -r line
	do
		pfx="${line%=*}="
		sfx="${line##*=}"
		# replace LOGFILENAME
		if echo "$sfx" | grep -q ^LOGFILENAME_FINAL
		then
			sfx="$LOGDIR/$(echo "$sfx" | { read a b c d e f g; get_logfilename_final "$b" "$c" "$d" "$e" "$f" "$g"; })"
			line="$pfx$sfx"
		elif echo "$sfx" | grep -q ^LOGFILENAME_INPROGRESS
		then
			sfx="$LOGDIR/$(echo "$sfx" | { read a b c d e f g; get_logfilename_inprogress "$b" "$c" "$d" "$e" "$f" "$g"; })"
			line="$pfx$sfx"
		fi
		# expand shell globs if relevant
		if echo "$line" | grep -q = && ! echo "$pfx" | grep -q 'Glob='
		then
			for entry in $sfx
			do
				echo "$pfx""$entry"
			done
		else
			echo "$line"
		fi
	done > "$confdir"/autogenerated-path.conf
done
