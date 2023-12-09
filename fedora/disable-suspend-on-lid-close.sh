#!/bin/bash

# yes, just go ahead into /etc/systemd/login.conf and find the key called HandleLidSwitch, uncomment it (delete the #) and change the option to ignore. You will need to restart for it to take effect. You will find a few other options in there you can play with also.

# from my notes....

# HandleLidSwitch to {hibernate,lock,suspend,sleep,ignore} in /etc/systemd/logind.conf

# Exit on error
set -e

echo "To disable suspend on lid close, open /etc/systemd/logind.conf, uncomment the key called HandleLidSwitch and change the option to 'ignore'. Restart for the change to take effect."
