#!/bin/sh
flatpak run com.slack.Slack --ozone-platform=wayland --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer $@
# slack --ozone-platform=wayland --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer $@
