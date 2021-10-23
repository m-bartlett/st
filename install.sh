#!/usr/bin/env bash

PATCHES=(
  boxdraw
  ligatures-boxdraw
  # scrollback
  # scrollback-mouse
  # scrollback-mouse-altscreen
  # scrollback-clearhistory
  # anysize
  # vertcenter
  blinking_cursor

  # font2
  font-zoom-remap

  # clipboard
  # csi_22_23-save-and-restore-window-title
  delkey
  # keyboard-select
  newterm-orphan
  w3m
  xresources-usr1-reload
  # vim-browse-custom
)

info() { printf "\e[34m$@\e[0m\n"; }
warn() { printf "\e[33m$@\e[0m\n"; }

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pushd "$__dir"

for p in ${PATCHES[@]}; do
  echo
  info $p
  patch -F3 < "patches/$p."*
  if (($?)); then
    warn "$p did not apply successfully"; sleep 0.75
    exit 1
  fi
done

make && sudo make install
make clean || true
git clean -df
git reset --hard