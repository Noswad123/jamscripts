#!/bin/sh

tmux rename-session Optimus
tmux new-window -t Optimus -d -n Weather
tmux send-keys -t Optimus:Weather "curl wttr.in" Enter

tmux select-window -t Optimus:Weather
tmux -u attach -t Optimus
