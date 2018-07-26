#!/bin/sh

wal -i ~/workspace/res/wallpapers
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

dunst &
compton &
nm-applet &
pa-applet --disable-notifications &
xfce4-power-manager &

dropbox &
/opt/Enpass/bin/runenpass.sh startWithTray &

case `hostname` in
  "blank")
    source ~/.config/ech/t500_gamma.sh
    setxkbmap -layout us,ru\
              -option grp:alt_shift_toggle\
              -option caps:escape\
              -option altwin:swap_lalt_lwin\
              -option lv3:ralt_switch\
	      -option misc:typo
  ;;
  "darwin")
    setxkbmap -layout rukbi_en,rukbi_ru\
              -option grp:win_space_toggle\
              -option caps:escape\
              -option apple:alupckeys
    xrandr --output DP1 --auto --primary\
           --output DP2 --auto --right-of DP1
  ;;
esac
