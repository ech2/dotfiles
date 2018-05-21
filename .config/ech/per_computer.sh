#/bin/sh
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
    setxkbmap -layout rukbi_en,rukbi_ru\
              -option grp:win_space_toggle\
              -option caps:escape\
              -option altwin:swap_lalt_lwin
    xfce4-power-manager &
  ;;
esac
