#!/usr/bin/env bash

PATCHES=(
  # vim-browse
  boxdraw
  ligatures-boxdraw
  xresources-usr1-reload
  scrollback
  scrollback-mouse
  scrollback-mouse-altscreen
  scrollback-clearhistory
  # anysize
  # vertcenter
  # blinking_cursor

  # font2
  font-zoom-remap

  # clipboard
  # csi_22_23-save-and-restore-window-title
  delkey
  # keyboard-select
  # newterm
  # newterm-orphan
  w3m
)

info() { printf "\e[34m$@\e[0m\n"; }
warn() { printf "\e[33m$@\e[0m\n"; }

for p in ${PATCHES[@]}; do
  echo
  info $p
  patch < "patches/$p."*
  if (($?)); then
    warn "$p did not apply successfully"; sleep 0.75
    break
  fi
done