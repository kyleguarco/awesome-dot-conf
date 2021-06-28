#!/bin/bash
# Like "take_screenshot.sh" but pastes the image into the clipboard.
# The output is written to /tmp first (in case the clip is lost).

FMTDATE=$(date +"%m_%d_%Y_%H%M%s")
SCRNAME="${FMTDATE}.png"

maim -um 4 -s > /tmp/"${SCRNAME}"

if [[ $? != 0 ]]; then
	notify-send "Screenshot" "Cancelled"
	rm ~/"${SCRNAME}"
	exit -1
fi

xclip -sel clip -target image/png -i /tmp/"${SCRNAME}"
notify-send "Screenshot" "Saved in clipboard (/tmp/${SCRNAME})"
exit 0

