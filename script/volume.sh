#!/bin/bash

# Both cases return the set volume
# Change 'print $4' to 'print $5' if the media server in use is Pulse
case $1 in
	"set")
	# $2: Sink; $3: dB (or %)
	amixer set $2 $3 | awk '$0~/%/{print $6"\;"; print $4"\;"}' 2< /dev/null | tr -d '[]%\n' ; echo
	# Output: LEFTON;LEFT;RIGHTON;RIGHT;
	;;
	"get")
	# First argument is sink
	amixer get $2 | awk '$0~/%/{print $6"\;"; print $4"\;"}' 2< /dev/null | tr -d '[]%\n' ; echo
	# Output: LEFTON;LEFT;RIGHTON;RIGHT;
	;;
esac
