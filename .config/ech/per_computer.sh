#!/bin/sh
# vim: set foldmarker={{,}} foldlevel=0 foldmethod=marker:

case `hostname` in
  'darwin')
    setxkbmap -layout rukbi_en,rukbi_ru\
              -option grp:win_space_toggle\
              -option caps:escape\
              -option apple:alupckeys
    xrandr --output DP1 --auto --primary\
           --output DP2 --auto --right-of DP1
  ;;
  'blank')
    export EDITOR='emacsclient -a "" -t'
    export VISUAL='emacsclient -a ""'
    setxkbmap -layout us,ru\
              -option grp:alt_shift_toggle\
              -option caps:escape\
              -option altwin:swap_lalt_lwin\
              -option lv3:ralt_switch\
	      -option misc:typo
    xfce4-power-manager &
  ;;
esac
