#!/usr/bin/env bash

PATCHES=(
  boxdraw
  ligatures-boxdraw
  xresources-usr1-reload
  scrollback
  scrollback-mouse
  scrollback-mouse-altscreen
  scrollback-clearhistory
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
  vim-browse-custom
)

info() { printf "\e[34m$@\e[0m\n"; }
warn() { printf "\e[33m$@\e[0m\n"; }

for p in ${PATCHES[@]}; do
  echo
  info $p
  patch -F3 < "patches/$p."*
  if (($?)); then
    warn "$p did not apply successfully"; sleep 0.75
    break
  fi
done
