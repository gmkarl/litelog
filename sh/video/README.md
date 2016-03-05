= sh/video =

Simple shell-script system service to log from video4linux2 devices.
When installed, devices should be immediately logged from on connect.
The service may also be directed to log manually via
`systemctl start litelog-sh-video@/dev/video0` for example.

Current recording formats supported:
 [x] video4linux
 [ ] alsa
 [ ] arbitrary urls

Current system services supported:
 [x] systemd
 [ ] openrc

Current encoding systems supported:
 [x] ffmpeg
 [ ] gstreamer
