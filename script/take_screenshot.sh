#!/bin/bash

FMTDATE=$(date +"%m_%d_%Y_%H%M%s")
SCRNAME="${FMTDATE}.png"

saved() {
	notify-send "Screenshot" "Saved as ${SCRNAME}"
	exit 0
}

not_saved() {
	notify-send "Screenshot" "Cancelled"
	rm ~/"${SCRNAME}"
	exit -1
}

maim -m 4 -s > ~/"${SCRNAME}"

if [[ $? != 0 ]]; then
	not_saved
fi

saved

