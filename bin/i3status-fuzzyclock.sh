#!/bin/sh
# shell script to prepend i3status with more stuff

i3status | while :
	do
		read line
		echo "$line | $(bayerntime.py)" || exit 1
	done
