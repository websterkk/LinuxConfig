#!/bin/bash

# options to be displyed
option0="i3"
option1="polybar"
option2="ncmpcpp"
option3="Rofi - Launch"
option4="Rofi - Power"
option5="Rofi - Wifi"
option6="mpd"

# Variable passed to rofi
options="$option0\n$option1\n$option2\n$option3\n$option4\n$option5\n$option6"

selected="$(echo -e "$options" | rofi -lines 13 -dmenu -p "xrandr")"
case $selected in
    $option0)
        exec gedit ~/.config/i3/config;;
    $option1)
        exec gedit ~/.config/polybar/config;;
    $option2)
        exec gedit ~/.config/ncmpcpp/config;;
    $option3)
	exec gedit ~/.config/rofi/myThemes/kasey.rasi;;
    $option4)
	exec gedit ~/.config/rofi/myThemes/power.rasi;;
    $option5)
        exec gedit ~/.config/rofi/myThemes/wifi.rasi;;
    $option6)
        exec gedit ~/.config/mpd/mpd.config;;
esac
