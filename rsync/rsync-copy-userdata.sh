#!/bin/bash

# Hint: You can generate a custom rsync command string from the GUI tool, grsync!

# Exit on error
set -e

# Sync files using rsync (checksum)
rsync -r -t -v --progress --ignore-existing -c -l -s '/run/media/jonathan/Big Boi/robocopy/jonat' /home/jonathan/Desktop/

# Sync files using rsync (no checksum)
# rsync -r -t -v --progress --ignore-existing -l -s '/run/media/jonathan/Big Boi/robocopy/jonat' /home/jonathan/Desktop/
