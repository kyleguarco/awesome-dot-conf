#!/bin/sh
# grab_battery.sh
#
# Returns the battery charge as text output

BATFILE=$1

cat /sys/class/power_supply/$BATFILE/capacity
