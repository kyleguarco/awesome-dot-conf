#!/bin/bash

# Both cases return the set volume
case $1 in
	"toggle")
		pamixer -t
	;;
	"set")
	# $3: dB (or %)
	case ${2::1} in
		"+")
		pamixer -i ${2/+/}
		;;
		"-")
		pamixer -d ${2/-/}
		;;
		*)
		pamixer --set-volume $2
		;;
	esac
	;;
	"get")
	;;
esac

[[ $(pamixer --get-mute) == "true" ]]
ISMUTE=$(echo $?)
VOL=$(pamixer --get-volume)
echo "$ISMUTE;$VOL;"
# Output: ON;VOL

