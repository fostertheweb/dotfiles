#!/bin/sh

source "$CONFIG_DIR/colors.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

DEFAULT=$GRAY_TRANSPARENT
POWER=0x6631d158
LOW=0x66ffd500
LOWER=0x66ff9230
CRITICAL=0x66ff4244

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
9[0-9] | 100)
  ICON=""
  BG=$DEFAULT
  COLOR=$WHITE
  ;;
[6-8][0-9])
  ICON=""
  BG=$DEFAULT
  COLOR=$WHITE
  ;;
[3-5][0-9])
  ICON=""
  BG=$LOW
  COLOR=$WHITE
  ;;
[1-2][0-9])
  ICON=""
  BG=$LOWER
  COLOR=$WHITE
  ;;
*)
  ICON=""
  BG=$CRITICAL
  COLOR=$RED
  ;;
esac

if [[ "$CHARGING" != "" ]]; then
  ICON="󱐋"
  BG=$POWER
  COLOR=$WHITE
fi

sketchybar --set "$NAME" \
  background.drawing=on \
  background.color="$BG" \
  background.corner_radius=8 \
  background.height=25 \
  background.padding_left=6 \
  background.padding_right=6 \
  icon="$ICON" \
  icon.drawing=off \
  icon.color="$COLOR" \
  label="${PERCENTAGE}%" \
  label.color="$COLOR" \
  label.padding_left=10
