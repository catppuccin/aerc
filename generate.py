#!/usr/bin/env python3

import urllib.request
import json

palette = json.load(urllib.request.urlopen('https://raw.githubusercontent.com/catppuccin/palette/main/palette-porcelain.json'))
with open('template', 'r') as file:
    template = file.read()

for flavor_name, flavor in palette.items():
    output = template
    for name, color in flavor.items():
        output = output.replace('$' + name, '#' + color['hex'])
    with open(f'dist/catppuccin-{flavor_name}', 'w') as file:
        file.write(output)
