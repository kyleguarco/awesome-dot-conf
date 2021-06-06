#!/bin/bash

# Both cases return the set volume
case $1 in
	"set")
	# $2: Sink; $3: dB (or %)
	amixer set $2 $3 | awk '$0~/%/{print $6"\;"; print $5"\;"}' 2< /dev/null | tr -d '[]%\n' ; echo
	# Output: LEFTON;LEFT;RIGHTON;RIGHT;
	;;
	"get")
	# First argument is sink
	amixer get Master | awk '$0~/%/{print $6"\;"; print $5"\;"}' 2< /dev/null | tr -d '[]%\n' ; echo
	# Output: LEFTON;LEFT;RIGHTON;RIGHT;
	;;
esac
