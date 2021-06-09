#!/bin/bash
# Links an image to the parent's asset folder for a wallpaper

ln -sf $1 ../assets/wallpaper

wal -i ../assets/wallpaper
cp ~/.cache/wal/colors.Xresources ~/.Xresources.pywal

xrdb -load ~/.Xresources

awesome-client 'awesome.restart()'
