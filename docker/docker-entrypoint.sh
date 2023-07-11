#!/bin/sh
#

set -e

if [ -f /usr/local/http-echo/http-echo-service.logo ]; then
    cat /usr/local/http-echo/http-echo-service.logo
fi

exec /usr/local/http-echo/http-echo-service --port "$ECHO_PORT" --bg-color "$ECHO_BG_COLOR"
