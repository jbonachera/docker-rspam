#!/bin/bash

echo "password = \"$PASSWORD\";" > /etc/rspamd/local.d/worker-controller.inc
echo "bind_socket = "*:11334";" >> /etc/rspamd/local.d/worker-controller.inc
if [ -n "$REDIS_HOST" ]; then
    echo servers = "$REDIS_HOST"\; >> /etc/rspamd/local.d/redis.conf
fi
exec /usr/bin/rspamd -c /etc/rspamd/rspamd.systemd.conf -f
