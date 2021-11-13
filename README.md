# st - simple terminal
st is a simple terminal emulator for X which sucks ~~less~~


### Dependencies
- libxft-bgra instead of libxft -> `Yay -S libxft-bgra`
- harfbuzz -> `pacman -S harfbuzz`
-

### My Customizations
- [scroll up and down by **half** pages using Shift + Page(Up/Down)](patches/scrollback.diff)

- [scroll up and down 1 line at a time with Shift + (Up/Down)](patches/scrollback.diff)

- [scrollback stops at exactly the start your terminal buffer history](patches/scrollback.diff) (_no more scrolling past into empty buffer!_)

- [scroll with your mouse!](patches/scrollback-mouse.diff) No modifier keys required :) [Also detects alt screen](patches/scrollback-mouse-altscreen.diff) and sends the raw instruction sequence for things which expect it (e.g. `less`, etc.)

- [ctrl+shift+L to completely purge buffer history and start at index 0](patches/scrollback-clearhistory.diff) (completely clears scrollback)

- [larger scrollback buffer (5000 lines)](patches/scrollback.diff)

- [increase font size: ctrl +](patches/font-zoom-remap.diff)<br/>
  [decrease font size: ctrl -](patches/font-zoom-remap.diff)<br/>
  [reset font size:    ctrl 0](patches/font-zoom-remap.diff)

- [delete key works as expected](patches/delkey.diff)

- [reads configuration from Xresources db](patches/xresources-usr1-reload.diff)

- [re-reads Xresources and reloads upon receiving a USR1 signal](patches/xresources-usr1-reload.diff) (patch mostly copied from [xst](https://github.com/gnotclub/xst/commit/c0ffcfbaf8af25468103dd92e0c7e83555e08c7a))

#### Standard patches:

- [**w3m**](patches/w3m.diff): enables persistent image display in st's X buffer, without it clears the buffer and the image gets erased in a single frame

- [**newterm-orphan**](patches/newterm.diff): ctrl+shift+enter to fork a **child** terminal in the same working directory

- [**boxdraw**](patches/boxdraw.diff): Enforces consistent and aligned box-drawing characters and other ASCII art symbols regardless of font. Test with `curl https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt`

- [**ligatures-boxdraw**](patches/ligatures.diff): Compatibility patch that allows rendering font ligatures while also using the boxdraw patch

- [**blinking_cursor**](patches/blinking_cursor.diff): Self explanatory

- [**vim-browse**](https://st.suckless.org/patches/vim_browse/): Enables interacting with the scrollback buffer using vim movement keybinds, such as searching and copying. [My version of the patch is customized to work with my other patches applied](patches/vim-browse-custom.diff).

___TO-PATCH___:

- [external pipe](https://st.suckless.org/patches/externalpipe/)

- [external pipe signal](https://st.suckless.org/patches/externalpipe-signal/) - need to change the instigating signal from USR1 to USR2 since USR1 is taken by Xresources reloader


### Build & Install
```bash
./patch.sh  # Applies each of my patches in the appropriate order
make && make install
```

<br/>

---

<br/>

### Running st
If you did not install st with make clean install, you must compile
the st terminfo entry with the following command:

    tic -sx st.info

See the man page for additional details.

To demonstrate the available cursor styles, try these commands:


### Blinking Cursor

Only cursor styles 0, 1, 3, 5, and 7 blink. Set cursorstyle accordingly.

    # Set cursor style (DECSCUSR), VT520.

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


### Boxdraw Ligatures

curl https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt


### Scrollback

My patch only scrolls by half-pages using PageUp and PageDown since it's easier for me to read and track the movement of commands and text areas. You can also scroll up/down one line at a time with shift+up and shift+down. Scrolling up will stop at exactly the starting index of `st`'s history buffer, preventing accidentally scrolling up into the empty buffer void.