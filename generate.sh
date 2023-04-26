#!/bin/sh

set -eu

PALETTE=$(curl -s https://raw.githubusercontent.com/catppuccin/palette/main/palette-porcelain.json)

for flavour in latte frappe macchiato mocha; do
  echo $PALETTE \
  | gojq --arg flavour "$flavour" -r \
    '.[$flavour] | map_values(.hex) | to_entries | reduce .[] as $it (""; . + "s/$\($it.key)/#\($it.value)/g;")' \
  | sed -f - template > dist/catppuccin-"$flavour"
done
