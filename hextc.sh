#!/bin/bash

set -euo pipefail

hexcolor="$1"
shift 1

for_shell=bash
style="fg"

while [ $# -gt 0 ]; do
  arg="$1"
  shift 1
  case "$arg" in
    "--shell")
      for_shell="$1"
      shift 1
      ;;
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

if [ "$for_shell" = "zsh" ]; then
  echo -n "%{"
fi
if [ "$hexcolor" = "reset" ]; then
  printf "\x1b[0m"
else
  _dehexcolor "$hexcolor" "$style"
fi
if [ "$for_shell" = "zsh" ]; then
  echo -n "%}"
fi
