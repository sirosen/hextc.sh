hextc.sh
========

"Mostly Portable" Hex to ANSI conversion.

For TrueColor terminals only, translate hex colors into ANSI escapes.

Usage
-----

Clone, and then run `hextc` to set various terminal colors in your
terminal.

Read script contents for usage details. (FIXME: document full usage better.)

Example Usage:

$ { ./hextc "fabd2f"; ./hextc "1d2021" --bg;
    echo "look at this";
    ./hextc reset }
