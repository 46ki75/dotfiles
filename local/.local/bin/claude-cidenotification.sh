#!/usr/bin/env bash

title="Claude Code | Notification"
input="$(cat)"
message="$(jq -r '.message' <<< "$input")"

notify.sh "$message" "$title"
