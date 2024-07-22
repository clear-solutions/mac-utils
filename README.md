# Documentation for `cpu_temp_monitor.sh` Script

## Overview

The `cpu_temp_monitor.sh` script is a simple utility designed to monitor the CPU temperature of a Mac and send a notification if the temperature exceeds 50°C. This script leverages built-in macOS utilities and the `osascript` command to display notifications.

## Prerequisites

- macOS operating system
- Basic knowledge of Terminal and shell scripting

## Script Breakdown

### get_cpu_temp Function

```bash
get_cpu_temp() {
  ioreg -n AppleSmartBattery -r | grep -i "temperature" | awk '{print $3}' | sed 's/[^0-9]*//g'
}
```

- **Purpose:** Extracts the CPU temperature.
- **Details:**
  - `ioreg -n AppleSmartBattery -r`: Lists hardware information.
  - `grep -i "temperature"`: Filters lines containing the term "temperature".
  - `awk '{print $3}'`: Extracts the third field (temperature value).
  - `sed 's/[^0-9]*//g'`: Cleans the extracted value, removing non-numeric characters.

### Main Script

```bash
# Convert to Celsius
cpu_temp=$(($(get_cpu_temp) / 100))

# Set the threshold
threshold=50

# Check if the temperature exceeds the threshold
if [ "$cpu_temp" -gt "$threshold" ]; then
  osascript -e 'display notification "CPU temperature exceeds 50°C!" with title "CPU Alert"'
fi
```

- **Convert to Celsius:** The `cpu_temp` value is divided by 100 to convert it from a higher scale to Celsius.
- **Set the threshold:** Defines the temperature limit (50°C) for triggering the alert.
- **Check and Notify:**
  - Compares the current CPU temperature (`cpu_temp`) to the threshold.
  - Uses `osascript` to display a macOS notification if the threshold is exceeded.

## Instructions

### Saving the Script

1. Open Terminal.
2. Create a new script file:
   ```bash
   touch cpu_temp_monitor.sh
   ```
3. Paste the script content into the file.
4. Save and exit (`Ctrl+X`, then `Y`, then `Enter`).

### Making the Script Executable

```bash
chmod +x cpu_temp_monitor.sh
```

### Automating the Script

To run the script at regular intervals, use `cron`:

1. Open the crontab editor:
   ```bash
   crontab -e
   ```
2. Add a new cron job to run the script every minute:
   ```bash
   * * * * * /path/to/cpu_temp_monitor.sh
   ```

Replace `/path/to/cpu_temp_monitor.sh` with the actual path to your script.

## Conclusion

This script provides a simple and effective way to monitor CPU temperature on a Mac and receive notifications if it exceeds a safe threshold. With some additional customization, it can be adapted for more complex monitoring and alerting requirements.
