#!/bin/bash

case "$1" in
	"next")
		# The player may not be able to go next
		playerctl next 2> /dev/null
		;;
	"prev" | "previous")
		# Same with above
		playerctl previous 2> /dev/null
		;;
	"toggle")
		playerctl play-pause
		;&
	"status")
		;;
esac

# PLAYING;TITLE;ARTIST;ART
# bool ISPLAY = $PLAYING=="PLAYING" ? 1 : 0;
ISPLAY=0 && [[ $(playerctl status) == "Playing" ]] && ISPLAY=1
TITLE=$(playerctl metadata xesam:title)
ARTIST=$(playerctl metadata xesam:artist)
ART=$(playerctl metadata mpris:artUrl)

echo "${ISPLAY};${TITLE};${ARTIST};${ART:="$HOME/.wallpaper"}"

