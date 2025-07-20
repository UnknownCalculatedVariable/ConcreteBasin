#!/bin/bash

# Path to your quotes file
QUOTES_FILE="$HOME/.cache/Rick_Quotes.txt"

# Check if the file exists
if [ ! -f "$QUOTES_FILE" ]; then
    echo "Error: Quotes file not found at $QUOTES_FILE"
    exit 1
fi

# Count the number of quotes
TOTAL_QUOTES=$(wc -l < "$QUOTES_FILE")

# Initialize counter
COUNTER=1

# Infinite loop to display quotes
while true; do
    # Get the current quote
    QUOTE=$(sed -n "${COUNTER}p" "$QUOTES_FILE")
    
    # Display the quote with its number
    echo "$QUOTE"
    
    # Increment counter or reset if we've reached the end
    COUNTER=$((COUNTER + 1))
    if [ $COUNTER -gt $TOTAL_QUOTES ]; then
        COUNTER=1
    fi
    
    # Wait 15 minutes (900 seconds) before showing the next quote
    sleep 25
done
