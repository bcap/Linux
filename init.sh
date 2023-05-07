#!/bin/zsh

# commands executed whenever a shell is opened in the container

mount -t debugfs nodev /sys/kernel/debug
