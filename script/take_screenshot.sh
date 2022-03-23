#!/bin/bash

FMTDATE=$(date +"%m_%d_%Y_%H%M%s")
SCRNAME="${FMTDATE}.png"

maim -um 4 -s > ~/"${SCRNAME}"

if [[ $? != 0 ]]; then
	notify-send "Screenshot" "Cancelled"
	rm ~/"${SCRNAME}"
	exit 1
fi

notify-send "Screenshot" "Saved as ${SCRNAME}"
exit 0
