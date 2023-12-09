#!/bin/bash

# Hint: You can generate a custom rsync command string from the GUI tool, grsync!

# Exit on error
set -e

# Declare vars
source='/home/jonathan/Desktop/jonat_bak'
destination='/mnt/usb-Samsung_PSSD_T7_Shield_S6SFNJ0W528979W-0:0-part1/ds2/tmp/'

# Sync files using rsync (checksum)
# rsync -r -t -v --progress --ignore-existing -c -l -s "$source" "$destination"

# Sync files using rsync (no checksum)
rsync -r -t -v --progress --ignore-existing -l -s "$source" "$destination"
