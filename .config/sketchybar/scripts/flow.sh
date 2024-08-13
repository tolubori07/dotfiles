#!/bin/bash

TIME=$(osascript -e 'tell application "Flow" to getTime')
PHASE=$(osascript -e 'tell application "Flow" to getPhase') 

if [ $PHASE = "Flow" ]; then
	COLOR=0xFFA6D189
elif [ $PHASE = "Break" ]; then
	COLOR=0xFFE78284
fi

sketchybar --set $NAME label="$TIME $PHASE" icon="󰄉" icon.color=$COLOR