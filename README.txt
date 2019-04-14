hextc.sh
========

"Mostly Portable" Hex to ANSI conversion.

For TrueColor terminals only, translate hex colors into ANSI escapes.

Usage
-----

Clone, and then run `hextc.sh` to set various terminal colors in your
terminal.

Or, if you're a fan of the gruvbox dark mode color palette, jump straight to
using `gruvbox/colorize.sh`

Read script contents for usage details. (FIXME: document full usage better.)

Example Usage:

$ ./hextc.sh "fabd2f"; ./hextc.sh "1d2021" --bg
$ echo "look at this"
$ ./hextc.sh reset
