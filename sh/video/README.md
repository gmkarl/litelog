sh/video
========

Simple system to log from video4linux2 devices.
When installed with systemd, devices should be immediately logged from 
on connect.
The service may also be directed to log manually via
`systemctl start litelog-sh-video@/dev/video0` for example.

Current recording formats supported:
- [x] video4linux2
- [ ] alsa
- [ ] arbitrary urls

Current system services supported:
- [x] systemd
- [ ] openrc
- [ ] cron

Current media frameworks supported:
- [x] ffmpeg
- [ ] gstreamer
