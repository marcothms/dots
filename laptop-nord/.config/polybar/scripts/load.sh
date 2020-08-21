#!/bin/sh

function load() {
    echo -n "$(cat /proc/loadavg | awk -F ' ' '{print $1,$2,$3}')"
}

load
