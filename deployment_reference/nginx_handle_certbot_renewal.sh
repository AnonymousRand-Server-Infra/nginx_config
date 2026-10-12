#!/usr/bin/env bash

set -ex

# so that nginx container can still read ssl certs (while also not giving perms to ALL users)
# SYNC: nginx group id! (currently 101)
chown -R "0:101" /etc/letsencrypt/
chmod -R 750 /etc/letsencrypt/

# also tell nginx to read the updated certs
# SYNC: nginx container name!
docker exec nginx nginx -s reload
