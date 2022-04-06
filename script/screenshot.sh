#!/bin/bash

FMTDATE=$(date +"%m_%d_%Y_%H%M%s")
SCRNAME="${FMTDATE}.png"
SAVEPATH="$HOME"
SAVEMSG="Saved to ${SCRNAME}"
COPY=1

SCRCMD="import -window root"

function sendnote() {
	notify-send "Screenshot" "$1"
}

while getopts ":sc" opt; do
	case $opt in
		s|select)
			SCRCMD="import"
			;;
		c|clip)
			COPY=0
			SAVEPATH="/tmp/"
			SAVEMSG+=" (copied to clipboard)"
			;;
	esac
done

shift $((OPTIND-1))

SAVEPATH="${SAVEPATH}/${SCRNAME}"
SCRCMD+=" ${SAVEPATH}"
$SCRCMD

SCRSTATUS=$?
if [[ $SCRSTATUS != 0 ]]; then
	sendnote "Either the screenshot was cancelled or there was an error. ER${SCRSTATUS}"
	rm "$SAVEPATH"
	exit 1
fi

if [[ $COPY ]]; then
	xclip -sel clip -t image/png < $SAVEPATH
fi

sendnote "$SAVEMSG"
