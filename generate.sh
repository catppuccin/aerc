#!/bin/sh -eu

PALETTE=$(curl -s https://raw.githubusercontent.com/catppuccin/palette/main/palette-porcelain.json)

for flavour in latte frappe macchiato mocha; do
  echo "$PALETTE" |
    gojq -r --arg flavour "$flavour" \
      '.[$flavour] | to_entries | map("s/$\(.key)/#\(.value.hex)/g;") | add' |
    sed -f - template >./dist/catppuccin-"$flavour"
done
