#!/bin/bash

BAT_C=$(cat /sys/class/power_supply/BAT0/capacity)
BAT_ISAC=$(cat /sys/class/power_supply/AC/online)

# data[1]: Charge; data[2]: Is charging
echo "${BAT_C};${BAT_ISAC};"
