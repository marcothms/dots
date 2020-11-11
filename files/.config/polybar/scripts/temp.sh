#!/bin/sh

echo "$(sensors | grep Tctl | head -1 | awk '{print $2}')"
