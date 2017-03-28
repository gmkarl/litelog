MODULE=video
#SYSTEMD_START=litelog-sh-video-compress.path
#SYSVINIT_START=litelog-sh-video-compress
include ../common.mk

dep:
	# Detecting GStreamer 1.0 w/ splitmuxsink for video logging
	gst-inspect-1.0 splitmuxsink >/dev/null

install: install-module

uninstall: uninstall-module
