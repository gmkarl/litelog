sh/systemd
==========

A simple setup for other modules to follow for systemd services.
Units are expected to be named litelog-<language>-<module>-<function> .

A service is provided which watches /etc/litelog and updates Path unit files when needed.
Updates are performed on Path entries as follows:

- "LOGFILENAME_FINAL <module> <date> <hostname> <compression> <extension>" is replaced by the complete path to the specified finalized logfile.  Where *'s are provided, a shell glob is produced.
- "LOGFILENAME_INPROGRESS <module> <date> <hostname> <compression> <extension>" is replaced by the complete path to the specified in-progress logfile.  Where *'s are provided, a shell glob is produced.
- LOGDIR is replaced by the locally configured value, usually /var/lib/litelog
- LITELOGDIR is replaced by the locally configured value, usually /usr/lib/litelog

This replacements are only performed on Path entries for now.
