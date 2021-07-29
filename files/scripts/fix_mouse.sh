#!/bin/sh

if [ ! "$1" ]; then
   echo "No device ID given ..."
   exit 1
fi

xinput --set-prop $1 'libinput Accel Profile Enabled' 0, 1
