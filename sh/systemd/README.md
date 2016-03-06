= sh/systemd =

A simple setup for other modules to follow for systemd services.
Units are expected to be named litelog-<language>-<module>-<function> .

A service is provided which watches /etc/litelog and updates Path unit files when needed.
For now, .path use the default paths of /usr/lib/litelog and /var/lib/litelog, which this
service adjusts.
A more robust solution may be to use .conf templates per module.

