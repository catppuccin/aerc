#!/bin/sh -eu

PALETTE=$(curl -s https://raw.githubusercontent.com/catppuccin/palette/main/palette-porcelain.json)

PROGRAM=$(cat <<EOF
reduce (.[\$flavour] | to_entries | .[]) as \$x
  (
    \$template;
    sub(\$x | "\\\\$\(.key)"; \$x | "#\(.value.hex)"; "g")
  )
EOF
)

for flavour in latte frappe macchiato mocha; do
  echo "$PALETTE" | jq -r \
    --arg flavour "$flavour" \
    --rawfile template ./template \
    "$PROGRAM" \
    >dist/catppuccin-"$flavour"
done
