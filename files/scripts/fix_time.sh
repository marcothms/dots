#!/bin/sh

timedatectl set-timezone Europe/Berlin
timedatectl set-ntp 1
sudo hwclock --systohc
