#!/bin/bash

# Hint: You can generate a custom rsync command string from the GUI tool, grsync!

# Exit on error
set -e

# Declare vars
source="/run/media/jonathan/big-boi/jonat_bak"
destination="/home/jonathan/Desktop/"

# Sync files using rsync (checksum)
rsync -r -t -v --progress --ignore-existing -c -l -s "$source" "$destination"

# Sync files using rsync (no checksum)
# rsync -r -t -v --progress --ignore-existing -l -s "$source" "$destination"
