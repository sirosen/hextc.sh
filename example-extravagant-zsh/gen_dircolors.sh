#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

_gruvbox_map () {
  case "$1" in
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
    aqua) echo "689d6a" ;;
    brightaqua) echo "83c07c" ;;
  esac
}

_gruv () {
  local hexcolor
  hexcolor="$(_gruvbox_map "$1")"
  shift 1
  ../hextc "$hexcolor" --dircolors "$@"
}

cat <<EOH
# 'tty' colorizes output to ttys, but not pipes. 'all' adds color characters to all output. 'none' shuts colorization
# off.
COLOR tty

# Below, there should be one TERM entry for each termtype that is colorizable
TERM ansi
TERM color_xterm
TERM color-xterm
TERM con132x25
TERM con132x30
TERM con132x43
TERM con132x60
TERM con80x25
TERM con80x28
TERM con80x30
TERM con80x43
TERM con80x50
TERM con80x60
TERM cons25
TERM console
TERM cygwin
TERM dtterm
TERM dvtm
TERM dvtm-256color
TERM Eterm
TERM eterm-color
TERM fbterm
TERM gnome
TERM gnome-256color
TERM jfbterm
TERM konsole
TERM konsole-256color
TERM kterm
TERM linux
TERM linux-c
TERM mach-color
TERM mlterm
TERM nxterm
TERM putty
TERM putty-256color
TERM rxvt
TERM rxvt-256color
TERM rxvt-cygwin
TERM rxvt-cygwin-native
TERM rxvt-unicode
TERM rxvt-unicode256
TERM rxvt-unicode-256color
TERM screen
TERM screen-16color
TERM screen-16color-bce
TERM screen-16color-s
TERM screen-16color-bce-s
TERM screen-256color
TERM screen-256color-bce
TERM screen-256color-s
TERM screen-256color-bce-s
TERM screen-256color-italic
TERM screen-bce
TERM screen-w
TERM screen.linux
TERM screen.xterm-256color
TERM screen.xterm-new
TERM st
TERM st-meta
TERM st-256color
TERM st-meta-256color
TERM tmux
TERM tmux-256color
TERM vt100
TERM xterm
TERM xterm-new
TERM xterm-16color
TERM xterm-256color
TERM xterm-256color-italic
TERM xterm-88color
TERM xterm-color
TERM xterm-debian
TERM xterm-termite

# EIGHTBIT, followed by '1' for on, '0' for off. (8-bit output)
EIGHTBIT 1

# global default
NORMAL 00
# normal file
FILE 00

# directory
DIR $(_gruv blue);1
# XX2, XX3, XX6, and XX7 directories (orange bg, bold)
OTHER_WRITABLE $(_gruv orange --bg);$(_gruv bg0_h);1
# symbolic link
LINK $(_gruv brightaqua)

# pipe, socket, block device, character device (lighter bg, normal text)
$(for key in FIFO SOCK DOOR BLK CHR; do
  echo "$key $(_gruv bg3 --bg)"
done)

# Orphaned symlinks, missing symlink targets
$(for key in ORPHAN MISSING; do
  echo "$key $(_gruv brightred);$(_gruv bg2 --bg)"
done)

# executables
$(for key in EXEC .cmd .exe .com .bat .reg .app; do
  echo "$key $(_gruv brightgreen);1"
done)

# Text, Markdown
$(for key in .txt .org .md .rs .adoc .mkd; do
  echo "$key $(_gruv fg3)"
done)

# Source
$(for key in \
  .h .hpp .c .C .cc .cpp .cxx .objc .cl \
  .sh .bash .csh .zsh \
  .el .vim .java .pl .pm .py .rb \
  .hs .php .htm .html .shtml .erb .haml \
  .xml .rdf .css .sass .scss .less .js .coffee .man \
  ".0" ".1" ".2" ".3" ".4" ".5" ".6" ".7" ".8" ".9" \
  .l .n .p .pod .tex .go .sql .csv .sv .svh .v .vh .vhd; do
  echo "$key $(_gruv green)"
done)

### Multimedia formats
$(for key in \
  .bmp .cgm .dl .dvi .emf .eps .gif .jpeg .jpg .JPG \
  .mng .pbm .pcx .pdf .pgm .png .PNG .ppm .pps .ppsx \
  .ps .svg .svgz .tga .tif .tiff .xbm .xcf .xpm .xwd \
  .xwd .yuv .aac .au .flac .m4a .mid .midi .mka .mp3 \
  .mpa .mpeg .mpg .ogg .opus .ra .wav .anx .asf .avi \
  .axv .flc .fli .flv .gl .m2v .m4v .mkv .mov .MOV .mp4 \
  .mp4v .mpeg .mpg .nuv .ogm .ogv .ogx .qt .rm .rmvb \
  .swf .vob .webm .wmv; do
  echo "$key $(_gruv brightpurple)"
done)

# Binary document formats and multimedia source
$(for key in \
  .doc .docx .rtf .odt .dot .dotx .ott .xls .xlsx \
  .ods .ots .ppt .pptx .odp .otp .fla .psd; do
  echo "$key $(_gruv purple)"
done)

# Archives, compressed
$(for key in \
  .7z .apk .arj .bin .bz .bz2 .cab .deb .dmg \
  .gem .gz .iso .jar .msi .rar .rpm .tar .tbz \
  .tbz2 .tgz .tx .war .whl .xpi .xz .z .Z .zip; do
  echo "$key $(_gruv yellow);1"
done)

# Semi-hidden files
$(for key in \
  ".log" "*~" "*#" ".bak" ".BAK" ".old" ".OLD" ".org_archive" \
  ".off" ".OFF" ".dist" ".DIST" ".orig" ".ORIG" ".swp" ".swo" "*,v"; do
  echo "$key $(_gruv gray);1"
done)

# special data/files
$(for key in .gpg .pgp .asc .3des .aes .enc .sqlite; do
  echo "$key $(_gruv red)"
done)
EOH
