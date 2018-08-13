#!/bin/env bash

_edirs=(
  "$HOME/.local/share/applications"
  "/usr/share/applications"
)

_recent_log="$HOME/.cache/dmenu_freq.log"

if [ ! -f $_recent_log ]; then
  echo lol
  touch $_recent_log
fi

echo_recent() {
  sort $_recent_log | uniq -c | sort | awk '{print $2}' 
}

find_desktop_entries() {
  find ${_edirs[*]} \
       -type f -name "*.desktop" \
  | sed 's!.*/!!'
}

open_and_log() {
  local sel="$@"

  case $sel in
    "")
      ;; # do nothing  
    *.desktop)
      echo $sel >> $_recent_log
      dex $(find ${_edirs[*]} -type f -name $sel -print -quit) &
      ;;
    *)
      echo $sel >> $_recent_log
      $($sel) &
      ;;
  esac

  mv $_recent_log $_recent_log"-tmp"
  tail -n200 $_recent_log"-tmp" > $_recent_log
  rm $_recent_log"-tmp"
} 

if [[ $1 == "-d" ]]; then
  echo debug
else
  s=$({ echo_recent && dmenu_path && find_desktop_entries; } | dmenu "$@")
  open_and_log $s
fi
