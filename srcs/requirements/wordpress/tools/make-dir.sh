#!/bin/bash

# Create base directories if they don't exist
if [ ! -d /home/codespace/data ]; then
    mkdir -p /home/codespace/data/mariadb
    mkdir -p /home/codespace/data/wordpress
fi
