#!/bin/sh

set -eu

PALETTE=$(curl -s https://raw.githubusercontent.com/catppuccin/palette/main/palette-porcelain.json)

for flavour in latte frappe macchiato mocha; do
  echo $PALETTE \
  | gojq --arg flavour "$flavour" -r \
    '.[$flavour] | to_entries | map("s/$\(.key)/#\(.value.hex)/g;") | add' \
  | sed -f - template > dist/catppuccin-"$flavour"
done
