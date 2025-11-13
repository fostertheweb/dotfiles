#!/bin/sh

source "$CONFIG_DIR/colors.sh"

# Always show the current date; append event info when available
DATE_LABEL=$(date '+%a %b %e')

# Get upcoming timed events today (excluding all-day events)
OUTPUT=$(icalBuddy -n -nc -npn -ea -li 10 -tf '%H:%M' -df '' -b '•' eventsToday 2>/dev/null)

EVENT_LABEL=""
CURRENT_TIME=$(date +%H:%M)
CURRENT_MINUTES=$(echo "$CURRENT_TIME" | awk -F: '{print $1*60 + $2}')

if [ -n "$OUTPUT" ] && [ "$OUTPUT" != "" ]; then
  # Create temporary file to process events
  TEMP_FILE=$(mktemp)
  echo "$OUTPUT" >"$TEMP_FILE"

  CURRENT_EVENT_TITLE=""

  while IFS= read -r line; do
    if echo "$line" | grep -q '^•'; then
      # This is a title line
      CURRENT_EVENT_TITLE=$(echo "$line" | sed 's/^•[[:space:]]*//')
    elif echo "$line" | grep -q '^[[:space:]]*[0-9][0-9]:[0-9][0-9]'; then
      # This is a time line
      EVENT_TIME=$(echo "$line" | grep -o '^[[:space:]]*[0-9][0-9]:[0-9][0-9]' | xargs)

      if [ -n "$EVENT_TIME" ] && [ -n "$CURRENT_EVENT_TITLE" ]; then
        EVENT_START_MINUTES=$(echo "$EVENT_TIME" | awk -F: '{print $1*60 + $2}')
        TIME_DIFF=$((CURRENT_MINUTES - EVENT_START_MINUTES))

        # Show this event if it hasn't started yet or began <= 5 minutes ago
        if [ $TIME_DIFF -le 5 ]; then
          EVENT_LABEL="$EVENT_TIME $CURRENT_EVENT_TITLE"
          break
        fi
      fi
      CURRENT_EVENT_TITLE=""
    fi
  done <"$TEMP_FILE"

  rm -f "$TEMP_FILE"
fi

if [ -n "$EVENT_LABEL" ]; then
  LABEL="$DATE_LABEL  •  $EVENT_LABEL"
else
  LABEL="$DATE_LABEL"
fi

sketchybar --set "$NAME" \
  icon="󰃮" \
  icon.color="$RED" \
  icon.padding_left=10 \
  icon.padding_right=10 \
  label="$LABEL" \
  label.color="$WHITE" \
  label.padding_right=10
