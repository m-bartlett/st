#!/usr/bin/env bash

PATCHES=(
  newterm-orphan
  # anysize
  boxdraw
  wide-glyph-boxdraw
  ligatures-boxdraw
  vertcenter-wide-glyph-boxdraw
  clearwin
  font2
  font-zoom-remap
  delkey
  # alpha
  w3m
  xresources-usr1-reload
  bold-is-not-bright
  font-height-background
)

trap "rm -rf ${_TMPDIR:="$(mktemp -d "/tmp/tmp.XXXXXXXX")"}" EXIT;

info() { printf "\e[94m$@\e[0m\n"; }
warn() { printf "\e[93m$@\e[0m\n"; }

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp -r "$__dir" "$_TMPDIR/"
cd "$_TMPDIR/$(basename "$__dir")"

for p in ${PATCHES[@]}; do
  echo
  info $p
  patch -F5 < "patches/$p."*
  if (($?)); then
    warn "$p did not apply successfully"; sleep 0.25
    echo $_TMPDIR
    read
    exit 1
  fi
done


make && sudo make install \
|| {
  warn "Could not compile"; sleep 0.75
  echo $_TMPDIR
  read
  exit 1
}
