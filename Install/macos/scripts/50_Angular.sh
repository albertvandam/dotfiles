#!/bin/sh

echo "Disable Angular Telemetry"

if [ -f $HOME/.angular-config.json ]; then
    /bin/rm -f $HOME/.angular-config.json
fi
