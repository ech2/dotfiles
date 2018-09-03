#!/bin/sh

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

dunst &
compton &
nm-applet &
pa-applet --disable-notifications &

dropbox &

case `hostname` in
  "blank")
    setxkbmap -layout us,ru\
              -option grp:alt_shift_toggle\
              -option caps:escape\
              -option altwin:swap_lalt_lwin\
              -option lv3:ralt_switch\
              -option misc:typo

    xfce4-power-manager & 
    xgamma -rgamma 1 -ggamma 0.94 -bgamma 0.9 &
    wal -i ~/workspace/res/wallpapers &
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
    wal -i ~/workspace/res/wallpapers &
  ;;
esac

