#!/bin/bash

FMTDATE=$(date +"%m_%d_%Y_%H%M%s")
SCRNAME="${FMTDATE}.png"
SAVEPATH="$HOME"
SAVEMSG="Saved to ${SCRNAME}"
COPY=1

MAIMCMD='maim -um 4'

function sendnote() {
	notify-send "Screenshot" "$1"
}

while getopts ":sc" opt; do
	case $opt in
		s|select)
			MAIMCMD+=' -s'
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
$MAIMCMD > $SAVEPATH

if [[ $COPY ]]; then
	xclip -sel clip -t image/png < $SAVEPATH
fi

SCRSTATUS=$?
if [[ $SCRSTATUS != 0 ]]; then
	sendnote "Either the screenshot was cancelled or there was an error. ER${SCRSTATUS}"
	rm ~/"${SCRNAME}"
	exit 1
fi

sendnote "$SAVEMSG"
