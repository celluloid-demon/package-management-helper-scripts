#!/bin/bash

# Exit on error
set -e

# Declare vars
synced_folder="$1"

# Yes, our teeth and ambitions are bared
sudo chmod g+rw "$synced_folder"
