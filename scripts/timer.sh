function show_progress {
    local elapsed=$((seconds - $1))
    local progress=$((elapsed * 100 / seconds))
    local filled=$((progress / 2))
    local empty=$((50 - filled))
    printf "\r["
    printf "%${filled}s" | tr ' ' '#'
    printf "%${empty}s" | tr ' ' '-'
    printf "] %3d%%" "$progress"
}

echo -e "⏰ Timer set for \033[1;33m$duration$unit\033[0m"

for ((i=seconds; i>=0; i--)); do
    clear
    if [ $i -le 10 ]; then
        ascii_countdown $i
    else
        echo -e "\n  Time remaining: \033[1;36m$((i / 60))m $((i % 60))s\033[0m"
    fi
    show_progress $i
    [ $i -gt 0 ] && sleep 1
done

# Final Alert
echo -e "\n\033[1;31m⏰ TIME'S UP! $duration$unit\033[0m"

# Notification
if command -v notify-send &> /dev/null; then
    notify-send "⏰ Timer Finished!" "$duration$unit is over!"
fi

# Sound
if command -v paplay &> /dev/null; then
    paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga 2> /dev/null
elif command -v aplay &> /dev/null; then
    aplay /usr/share/sounds/alsa/Front_Center.wav 2> /dev/null
elif command -v beep &> /dev/null; then
    beep -f 800 -l 300 -r 3
fi
(END)
