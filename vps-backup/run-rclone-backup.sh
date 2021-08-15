#!/bin/bash

session="rclone-backup"
dir="/root"
title="rclone-backup"
cmd="cd $dir && ./backup.sh "

tmux new -d -s "$session"
tmux set-option mouse on
tmux set -g pane-border-status top
tmux set -g pane-border-format "#{pane_index} #{pane_title}"
tmux set -g pane-border-style fg=cyan

tmux split-window -f -h -t "$session" "$cmd"
tmux select-pane -T "$title"

tmux kill-pane -t "$session":0.0
tmux select-layout -t "$session" tiled
