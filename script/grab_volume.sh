#!/bin/sh
# grab_volume.sh
#
# Returns the current volume from the specified output sink.

SINK=$1

# See https://bbs.archlinux.org/viewtopic.php?pid=695893#p695893
amixer get $1 | awk '$0~/%/{print $5}' | tr -d '[]%'
