#!/bin/bash

# Read battery status and capacity
STATUS=$(cat /sys/class/power_supply/BAT0/status)
CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)

# If running on battery and it drops below 10%, shut down gracefully
if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -lt 10 ]; then
    logger "WARNING: Battery critically low ($CAPACITY%). Initiating graceful shutdown."
    /sbin/shutdown -h now
fi
