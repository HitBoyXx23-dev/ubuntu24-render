#!/usr/bin/env bash
set -Eeuo pipefail

PORT="${PORT:-10000}"

sed -i "s/listen 10000;/listen ${PORT};/" /etc/nginx/nginx.conf

mkdir -p \
  /tmp/.X11-unix \
  /tmp/runtime-user \
  /run/nginx \
  /var/log/supervisor

chmod 1777 /tmp/.X11-unix
chown user:user /tmp/runtime-user
chmod 700 /tmp/runtime-user

rm -f /tmp/.X0-lock

exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
