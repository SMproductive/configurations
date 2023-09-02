#!/usr/bin/env bash

battery_voltage=$(upower --show-info $(upower --enumerate |\
grep 'BAT') |\
egrep "voltage" |\
awk '{print $2}')
cell_voltage=$(echo "print($battery_voltage/2)" | python3)

battery_percent=$(upower --show-info $(upower --enumerate |\
grep 'BAT') |\
egrep "percent" |\
awk '{print $2}')

battery_capacity=$(upower --show-info $(upower --enumerate |\
grep 'BAT') |\
egrep "capacity" |\
awk '{print $2}')

date_formatted=$(date "+%Y-%m-%d - %H:%M")

echo $cell_voltage"V -" $battery_percent "/" $battery_capacity "|" $date_formatted
