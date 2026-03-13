#!/bin/bash

# Waybar custom module: shows group tabs for the active window.

SOCKET="/run/user/$(id -u)/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"

get_group_info() {
    local active_json
    active_json=$(hyprctl activewindow -j 2>/dev/null) || return

    local count
    count=$(echo "$active_json" | jq '.grouped | length')

    if [ "$count" -le 1 ]; then
        local title
        title=$(echo "$active_json" | jq -r '.title // ""')
        title="${title//&/&amp;}"
        title="${title//</&lt;}"
        title="${title//>/&gt;}"
        title="${title//\"/\\\"}"
        echo "{\"text\": \"${title}\", \"class\": \"window\"}"
        return
    fi

    local active_addr
    active_addr=$(echo "$active_json" | jq -r '.address')

    local clients
    clients=$(hyprctl clients -j 2>/dev/null) || return

    local grouped
    grouped=$(echo "$active_json" | jq -r '.grouped[]')

    local tabs=""
    while IFS= read -r addr; do
        local title
        title=$(echo "$clients" | jq -r --arg a "$addr" '.[] | select(.address == $a) | .title' | cut -c1-25)
        [ -z "$title" ] && continue

        # Escape XML special chars
        title="${title//&/&amp;}"
        title="${title//</&lt;}"
        title="${title//>/&gt;}"

        if [ "$addr" = "$active_addr" ]; then
            tabs="${tabs}<span foreground='#b4e718' font_weight='bold'>${title}</span>  "
        else
            tabs="${tabs}${title}  "
        fi
    done <<< "$grouped"

    # Escape quotes for JSON
    tabs="${tabs//\"/\\\"}"
    echo "{\"text\": \"${tabs}\", \"tooltip\": \"${count} grouped windows\", \"class\": \"active\"}"
}

get_group_info

socat -U - "UNIX-CONNECT:${SOCKET}" 2>/dev/null | while IFS= read -r event; do
    case "$event" in
        activewindow\>\>*|changegroupactive\>\>*|movewindow\>\>*|openwindow\>\>*|closewindow\>\>*)
            get_group_info
            ;;
    esac
done
