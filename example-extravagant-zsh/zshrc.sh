#!/bin/zsh

# colorizing
# eval $(dircolors ~/.zsh_config/dircolors)
autoload -U colors && colors

# set prompts
setopt prompt_subst

_gruvbox_map () {
  case "$1" in
    reset) echo "reset" ;;
    bg0_h) echo "1d2021" ;;
    bg|bg0) echo "282828" ;;
    bg0_s) echo "32302f" ;;
    bg1) echo "3c3836" ;;
    bg2) echo "504945" ;;
    bg3) echo "665c54" ;;
    bg4) echo "7c6f64" ;;
    fg0) echo "fbf1c7" ;;
    fg|fg1) echo "ebdbb2" ;;
    fg2) echo "d5c4a1" ;;
    fg3) echo "bdae93" ;;
    fg4|lightgrey|lightgray) echo "a89984" ;;
    grey|gray) echo "928374" ;;
    red) echo "cc241d" ;;
    brightred) echo "fb4934" ;;
    green) echo "98971a" ;;
    brightgreen) echo "b8bb26" ;;
    yellow) echo "d79921" ;;
    brightyellow) echo "fabd2f" ;;
    orange) echo "d65d0e" ;;
    brightorange) echo "fe8019" ;;
    blue) echo "458588" ;;
    brightblue) echo "83a598" ;;
    purple) echo "b16286" ;;
    brightpurple) echo "d3869b" ;;
    aqua) echo "83c07c" ;;
    brightaqua) echo "689d6a" ;;
  esac
}

_color_text () {
  local text
  text="$1"
  shift 1
  echo -n "%{"
  while [ $# -gt 0 ]; do
    case "$1" in
      "--bold")
        hextc "bold"
        ;;
      "--fg")
        shift 1
        hextc "$(_gruvbox_map "$1")"
        ;;
      "--bg")
        shift 1
        hextc "$(_gruvbox_map "$1")" --bg
        ;;
    esac
    shift 1
  done
  echo -n "%}"
  echo -n "$text"
  hextc "reset"
}

# part of the prompt is exit code when nonzero
exit_code_prompt() {
  local rc=$?
  if [ $rc -ne 0 ]; then
    _color_text " $rc " --bold --bg red --fg bg0_h
  fi
}

precmd () {
    local ecodeprompt="$(exit_code_prompt)"
    local wd="${(%):-%~} "  # working directory
    local eol=" \$ " # end of line

    if [ -n "$ecodeprompt" ]; then
        ecodeprompt="${ecodeprompt}"$'\n'
    fi

    PROMPT="$(_color_text " %* " --bg bg1 --fg fg4)"
    PROMPT="${PROMPT}$(_color_text " $wd" --bg bg2 --fg yellow --bold)"

    local current_branch
    current_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
    if [ -n "$current_branch" ]; then
        PROMPT="$(_color_text "ᚠ ${current_branch} " --bold --fg bg1 --bg aqua)${PROMPT}"
    fi

    if [ "$((${#wd} + ${#current_branch}))" -gt 40 ];
    then
        eol=$'\n'"\$ "
    fi

    PROMPT="${ecodeprompt}${PROMPT}$eol"
}
