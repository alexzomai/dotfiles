#!/usr/bin/env bash

# соберём список клиентов и их workspace
clients=$(hyprctl -j clients)
workspaces=$(echo "$clients" | jq -r '.[].workspace.id' | sort -n | uniq)

output=""
for ws in $workspaces; do
  icons=""
  # соберём иконки по классам
  while read -r class; do
    case "$class" in
      org.telegram.desktop) icon="" ;;
      code|code-url-handler) icon="" ;;
      spotify) icon="" ;;
      firefox) icon="" ;;
      *) icon="" ;;
    esac
    icons+=" $icon"
  done < <(echo "$clients" | jq -r ".[] | select(.workspace.id==$ws) | .class")
  output+="$ws:$icons   "
done

echo "$output"
