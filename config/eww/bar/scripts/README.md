# Eww Bar Scripts Manager

This `main.sh` script is a centralized manager for various helper scripts used by the Eww bar. It combines the functionality of multiple individual scripts into one, making it easier to manage and execute them.

## Usage

To use the script, run it with one of the following arguments:

```bash
./main.sh <argument>
```

### Available Arguments

*   `--battery-icon`: Get the current battery icon based on charge level and status.
*   `--battery-icon-subscribe`: Continuously update the battery icon every second.
*   `--battery-percent`: Get the current battery percentage.
*   `--battery-percent-subscribe`: Continuously update the battery percentage every second.
*   `--date`: Get the current date in `mm/dd/yy` format.
*   `--gammastep-toggle`: Toggle gammastep on and off.
*   `--screenshot-full`: Take a screenshot of the entire screen.
*   `--screenshot-sectional`: Take a screenshot of a selected area of the screen.
*   `--wifi-icon`: Get the current Wi-Fi icon based on signal strength.
*   `--wifi-icon-subscribe`: Continuously update the Wi-Fi icon when network status changes.
*   `--wifi-toggle`: Toggle Wi-Fi on and off.
*   `--workspaces`: Get the current Sway/i3 workspace status for Eww.
*   `--workspaces-subscribe`: Continuously update the workspace status on change.

For continuous updates in your Eww bar, you should use the `-subscribe` arguments (e.g., `script-var --battery-icon-subscribe`). For one-off actions, like taking a screenshot, use the regular arguments.

## How to Add a New Script

To add a new script to `main.sh`, follow these steps:

### 1. Create a Function for Your Script

Open `main.sh` in a text editor. At the top of the script, in the "Function Definitions" section, add a new Bash function that contains the logic of your script. It's a good practice to name the function with a leading underscore, for example `_my_new_script`.

```bash
_my_new_script() {
    # Your script's logic goes here
    echo "Hello from my new script!"
}
```

### 2. Add a New Argument to the `case` Statement

Scroll down to the `case` statement in the "Main Script Logic" section. Add a new entry for your script. This will be the command-line argument you'll use to call your script.

```bash
case "$1" in
    # ... existing cases ...
    --my-new-script)
        _my_new_script
        ;;
    *)
    # ...
esac
```

If your script needs to run continuously, you can add a `subscribe` version as well:

```bash
case "$1" in
    # ... existing cases ...
    --my-new-script)
        _my_new_script
        ;;
    --my-new-script-subscribe)
        while true; do
            _my_new_script
            sleep 5 # Adjust sleep duration as needed
        done
        ;;
    *)
    # ...
esac
```

### 3. Update the Usage Information

Finally, add your new argument to the usage information in the `if [ "$#" -eq 0 ]; then` block, so that users can discover it.

```bash
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <option>"
    echo "Available options:"
    # ... existing options ...
    echo "  --my-new-script"
    echo "  --my-new-script-subscribe"
    exit 1
fi
```

That's it! You can now run your new script using `./main.sh --my-new-script`.
