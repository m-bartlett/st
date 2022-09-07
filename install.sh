#!/usr/bin/env bash

PATCHES=(
  newterm-orphan
  bold-is-not-bright
  # anysize
  # boxdraw
  # ligatures-boxdraw
  ligatures
  clearwin
  # vertcenter
  # wideglyph-anysize-vertcenter
  # wideglyph-boxdraw
  wide-glyph
  font2
  font-zoom-remap
  delkey
  # alpha
  w3m
  xresources-usr1-reload
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
