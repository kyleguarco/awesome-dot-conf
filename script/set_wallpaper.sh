#!/bin/bash
# Links an image to the parent's asset folder for a wallpaper

rm ../assets/wallpaper
ln -s $1 ../assets/wallpaper

