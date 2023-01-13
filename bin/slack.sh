#!/bin/sh
flatpak run --socket=wayland com.slack.Slack --ozone-platform=wayland --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer
