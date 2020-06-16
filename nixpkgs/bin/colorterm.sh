#!/usr/bin/env bash

if [[ "$TERM" = "screen"* ]] && [[ -n "$TMUX" ]]; then
  if [ "$1" == "prod" ]; then
    tmux select-pane -P 'bg=#89323D'
  elif [ "$1" == "dev" ]; then
    tmux select-pane -P 'bg=#192436'
  elif [ "$1" == "other" ]; then
    tmux select-pane -P 'bg=#111111'
  else
    tmux select-pane -P 'bg=#000000'
  fi;
else
  if [ "$1" == "prod" ]; then
    printf '\033]11;#331C1F\007'
  elif [ "$1" == "dev" ]; then
    printf '\033]11;#192436\007'
  elif [ "$1" == "other" ]; then
    printf '\033]11;#111111\007'
  else
    printf '\033]11;#000000\007'
  fi
fi
