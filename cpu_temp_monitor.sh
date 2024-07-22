#!/bin/bash

# Function to get the CPU temperature
get_cpu_temp() {
  ioreg -n AppleSmartBattery -r | grep -i "temperature" | awk '{print $3}' | sed 's/[^0-9]*//g'
}

# Convert to Celsius
cpu_temp=$(($(get_cpu_temp) / 100))

# Set the threshold
threshold=50

# Check if the temperature exceeds the threshold
if [ "$cpu_temp" -gt "$threshold" ]; then
  osascript -e 'display notification "CPU temperature exceeds 50°C!" with title "CPU Alert"'
fi
