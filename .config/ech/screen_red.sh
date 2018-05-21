#!/bin/bash

screen_red() {
  local state="$HOME/.screen_red"
  if [ -f $state ]; then
    redshift -x && rm $state;
  else
    redshift -O $1 && touch $state
  fi
}

screen_red $1

unset -f screen_red
