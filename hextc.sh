#!/bin/bash

set -euo pipefail

hexcolor="$1"
shift 1

style="fg"

while [ $# -gt 0 ]; do
  arg="$1"
  shift 1
  case "$arg" in
    "--bg")
      style="bg"
      ;;
    *)
      echo "err: usage"
      exit 2
      ;;
  esac
done

_dehexcolor () {
  local r g b
  r="$(cut -c-2 <<< "$1")" r=$((16#$r))
  g="$(cut -c3-4 <<< "$1")"
  g=$((16#$g))
  b="$(cut -c5-6 <<< "$1")"
  b=$((16#$b))
  if [ -n "$2" ] && [ "$2" = "bg" ]; then
    printf "\x1b[48;2;%s;%s;%sm" "$r" "$g" "$b"
  else
    printf "\x1b[38;2;%s;%s;%sm" "$r" "$g" "$b"
  fi
}

_zsh_echo () {
  set +u
  if echo "$SHELL" | grep "zsh" > /dev/null; then
    echo -n "$1"
  fi
  set -u
}

_zsh_echo '%{'
if [ "$hexcolor" = "reset" ]; then
  printf "\x1b[0m"
else
  _dehexcolor "$hexcolor" "$style"
fi
_zsh_echo '%}'
