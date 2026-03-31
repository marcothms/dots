#!/bin/bash
dbus-monitor --session "type='signal',interface='org.gnome.ScreenSaver'" |
  while read x; do
    case "$x" in 
      *"boolean true"*) echo SCREEN_LOCKED; ssh-add -D;;
      *"boolean false"*) echo SCREEN_UNLOCKED;;  
    esac
  done
