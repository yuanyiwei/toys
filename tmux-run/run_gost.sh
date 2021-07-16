#!/bin/bash

session="gost"
dir="/home/totoro/gost"
title="gost"
cmd="cd $dir && ./gost -L='totoro:totoro@:11111'"

tmux new -d -s "$session"
tmux set-option mouse on
tmux set -g pane-border-status top
tmux set -g pane-border-format "#{pane_index} #{pane_title}"
tmux set -g pane-border-style fg=cyan

tmux split-window -f -h -t "$session" "$cmd"
tmux select-pane -T "$title"

tmux kill-pane -t "$session":0.0
tmux select-layout -t "$session" tiled

