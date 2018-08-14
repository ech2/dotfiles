#!/bin/bash

browser_open() {
  if xargs curl --output /dev/null --silent --head --fail <<< "$@"
  then
    local r="$@"
  else
    local r="https://duckduckgo.com/?q=""$@"
  fi
  chromium "$r"
}

browser_open "$@"
