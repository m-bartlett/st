# st - simple terminal
st is a simple terminal emulator for X which sucks ~~less~~


## Installation

    make && make install


## Running st
If you did not install st with make clean install, you must compile
the st terminfo entry with the following command:

    tic -sx st.info

See the man page for additional details.

To demonstrate the available cursor styles, try these commands:


## Cursor style

Only cursor styles 0, 1, 3, 5, and 7 blink. Set cursorstyle accordingly.

Set cursor style (DECSCUSR), VT520.
Ps = 0  ⇒  blinking block.
Ps = 1  ⇒  blinking block (default).
Ps = 2  ⇒  steady block.
Ps = 3  ⇒  blinking underline.
Ps = 4  ⇒  steady underline.
Ps = 5  ⇒  blinking bar, xterm.
Ps = 6  ⇒  steady bar, xterm.

echo -e -n "\x1b[\x30 q" # Blinking block
echo -e -n "\x1b[\x31 q" # Blinking block (default)
echo -e -n "\x1b[\x32 q" # Steady block
echo -e -n "\x1b[\x33 q" # Blinking underline
echo -e -n "\x1b[\x34 q" # Steady underline
echo -e -n "\x1b[\x35 q" # Blinking bar
echo -e -n "\x1b[\x36 q" # Steady bar
echo -e -n "\x1b[\x37 q" # Blinking st cursor
echo -e -n "\x1b[\x38 q" # Steady st cursor


# Boxdraw ligatures

curl https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt


# Scrollback

My patch only scrolls by half-pages using PageUp and PageDown since it's easier for me to read and track the movement of commands and text areas.
Also you can scroll up/down one line at a time with shift+up and shift+down