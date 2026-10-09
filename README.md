# nginx config

## notes

- there is no deploy script here since it tends to break the services behind it, and besides we probably don't need to redeploy nginx by itself THAT often :3
- we use `envsubst` that nginx's docker image provides automatically to interpolate environment variables within nginx config files (so we can pass `.env` -> compose.yaml -> `environment:` key -> environment inside container for `envsubst`).
    - any files which you want to interpolate must be placed in `/etc/nginx/templates/` in the container with filename ending in `.template`, and their paths inside that directory will be mirrored over to `/etc/nginx/conf.d/` after interpolation.
    - this does also mean that interpolated snippets are forced into `/etc/nginx/conf.d/snippets/` instead of the usual `/etc/nginx/snippets/`, so keep that in mind when including these snippets.
