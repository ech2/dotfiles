#!/bin/env bash

_edirs=(
  "$HOME/.local/share/applications"
  "/usr/share/applications"
)

_recent_log="$HOME/.cache/dmenu_freq.log"

if [ ! -f $_recent_log ]; then
  touch $_recent_log
fi

echo_recent() {
  sort $_recent_log | uniq -c | sort -r | awk '{print $2}' 
}

find_desktop_entries() {
  find "${_edirs[0]}" "${_edirs[1]}" -name "*.desktop" \
  | sed 's!.*/!!'
}

open_and_log() {
  local sel="$@"
  local sel_which=$(which $sel)

  if [[ $sel == "" ]]; then
    return
  elif [[ -x $sel_which ]]; then
    $($sel) &
  else
    dex $(find ${_edirs[*]} -type f -name $sel -print -quit) &
  fi

  echo "$sel" >> $_recent_log

  mv $_recent_log $_recent_log"-tmp"
  tail -n200 $_recent_log"-tmp" > $_recent_log
  rm $_recent_log"-tmp"
} 

if [[ $1 == "-d" ]]; then
  echo debug
elif [[ $1 == "-c" ]]; then
  rm $_recent_log
else
  s=$({ echo_recent && dmenu_path && find_desktop_entries; } | dmenu -i "$@")
  open_and_log $s
fi

