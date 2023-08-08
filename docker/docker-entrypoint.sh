#!/bin/sh
#

set -e

if [ -z "$ECHO_PORT" ]; then
    echo "Set the value ECHO_PORT variable" >&2
    exit 1
fi

if [ -z "$ECHO_BG_COLOR" ]; then
    echo "Set the value ECHO_BG_COLOR variable" >&2
    exit 2
fi

if [ -f /usr/local/http-echo/http-echo-service.logo ]; then
    cat /usr/local/http-echo/http-echo-service.logo
fi

exec /usr/local/http-echo/http-echo-service --port "$ECHO_PORT" --bg-color "$ECHO_BG_COLOR"
