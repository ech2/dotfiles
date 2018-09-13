#!/bin/sh

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

dunst &
compton &
nm-applet &
pa-applet --disable-notifications &

#dropbox &
yandex-disk-indicator &

wallpaper=~/workspace/res/wallpapers_2/

case `hostname` in
  "blank")
    setxkbmap -layout us,ru\
              -option grp:alt_shift_toggle\
              -option caps:escape\
              -option altwin:swap_lalt_lwin\
              -option lv3:ralt_switch\
              -option misc:typo

    ~/.config/ech/t550_gamma.sh &
    xfce4-power-manager & 
    wal -st -i $wallpaper &
  ;;
  "darwin")
    setxkbmap -layout us,ru\
              -option grp:alt_shift_toggle\
              -option caps:escape\
              -option apple:alupckeys\
              -option lv3:rwin_switch\
              -option misc:typo
    xrandr --output DP1 --auto --primary\
           --output DP2 --auto --right-of DP1 && \
    wal -st -i $wallpaper &
  ;;
esac

