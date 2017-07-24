#!/bin/bash

echo "password = \"$PASSWORD\";" > /etc/rspamd/local.d/worker-controller.inc
echo "bind_socket = "*:11334";" >> /etc/rspamd/local.d/worker-controller.inc
if [ -n "$REDIS_HOST" ]; then
    echo servers = "$REDIS_HOST"\; >> /etc/rspamd/local.d/redis.conf
    echo "classifier \"bayes\" {
    tokenizer {
    name = \"osb\";
    }
    backend = \"redis\";
    servers = \"${REDIS_HOST}:6379\";
    min_tokens = 11;
    min_learns = 200;
    autolearn = true;
  }" > /etc/rspamd/local.d/statistic.conf
fi
exec /usr/bin/rspamd -c /etc/rspamd/rspamd.conf -f
