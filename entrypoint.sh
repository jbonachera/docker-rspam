#!/usr/bin/bash

echo "password = \"$PASSWORD\";" > /etc/rspamd/local.d/worker-controller.inc
exec /usr/bin/rspamd -c /etc/rspamd/rspamd.systemd.conf -f
