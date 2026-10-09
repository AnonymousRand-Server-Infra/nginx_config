# IMPORTANT: this only works if `/etc/letsencrypt/` is bind mounted onto the host and certbot
# runs on the host! otherwise it wouldn't make sense to copy this into the nginx container
# (we only put this script on the host here first, to be copied into nginx container and then
# reflected back out by a bind mount into `/etc/letsencrypt/`, to make it exist in the repo)

#!/usr/bin/env bash

set -x

# so that nginx container can still read ssl certs (while also not giving perms to ALL users)
# SYNC: nginx group id! (currently 101)
chown -R "0:101" /etc/letsencrypt/
chmod -R 750 /etc/letsencrypt/

# also tell nginx to read the updated certs
# SYNC: nginx container name!
docker exec nginx nginx -s reload
