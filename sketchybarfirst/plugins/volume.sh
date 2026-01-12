#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

source "$HOME/.config/colors.sh"
source "$HOME/.config/icons.sh"

volume=$(osascript -e 'output volume of (get volume settings)')

case $VOLUME in
[6-9][0-9] | 100)
	ICON=${ICONS_VOLUME[3]}
	COLOR=$COLOR_MAGENTA_BRIGHT
	;;
[3-5][0-9])
	ICON=${ICONS_VOLUME[2]}
	COLOR=$COLOR_MAGENTA_BRIGHT
	;;
[1-9] | [1-2][0-9])
	ICON=${ICONS_VOLUME[1]}
	COLOR=$COLOR_MAGENTA
	;;
*)
	ICON=${ICONS_VOLUME[0]}
	COLOR=$COLOR_MAGENTA
	;;
esac

sketchybar --set volume_icon icon="$ICON"
sketchybar --set volume_icon icon.padding_left="$PADDING_LEFT"
sketchybar --set volume_icon icon.padding_right="$PADDING_RIGHT"
sketchybar --set "$NAME" label="$volume%"
