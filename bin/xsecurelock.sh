#!/bin/sh
export XSECURELOCK_NO_COMPOSITE=1
export XSECURELOCK_DISCARD_FIRST_KEYPRESS=0
export XSECURELOCK_PASSWORD_PROMPT=asterisks
export XSECURELOCK_FONT="Hack:style=Regular:size=12"

/usr/bin/xsecurelock
