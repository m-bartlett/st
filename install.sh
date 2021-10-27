#!/usr/bin/env bash
set -o errexit

PATCHES=(
  newterm-orphan
  boxdraw
  ligatures-boxdraw
  # scrollback
  # scrollback-mouse
  # scrollback-mouse-altscreen
  # scrollback-clearhistory
  # anysize
  # vertcenter
  # blinking_cursor

  font2
  font-zoom-remap

  # clipboard
  # csi_22_23-save-and-restore-window-title
  delkey
  # keyboard-select
  w3m
  xresources-usr1-reload
  # vim-browse-custom
)

export _TMPDIR="$(mktemp -d "$/tmp/tmp.XXXXXXXX")";
trap "rm -rfv $_TMPDIR" RETURN;
pushd "$_TMPDIR"

info() { printf "\e[34m$@\e[0m\n"; }
warn() { printf "\e[33m$@\e[0m\n"; }

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp -r "$__dir" "$_TMPDIR"
pushd "$_TMPDIR"

for p in ${PATCHES[@]}; do
  echo
  info $p
  patch -F3 < "patches/$p."*
  if (($?)); then
    warn "$p did not apply successfully"; sleep 0.75
    exit 1
  fi
done

echo 'cp -r ~/Projects/st . ; cd st ; ./install.sh' | tmpdir ; st

make && sudo make install