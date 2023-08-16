#!/bin/sh

caddy run --config /Caddyfile &

params=""
[[ -f /geoip/GeoLite2-City.mmdb ]] && params="--geoip-database=/geoip/GeoLite2-City.mmdb"

goaccess --log-format=CADDY --real-time-html --addr=127.0.0.1 --port=3000 --log-file=/log/access.log \
         --agent-list --with-output-resolver --real-os --no-query-string --output=/www/index.html \
         --persist --restore --db-path=/cache $params --ws-url="$WS_URL" &

wait -n
exit $?