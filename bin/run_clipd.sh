#!/bin/bash

pkill -SIGTERM -f clipmenud || true
killall clipnotify || true
killall xclip || true

CM_MAX_CLIPS=40 CM_SELECTIONS='clipboard' bash /usr/bin/clipmenud &
