FROM nginx:alpine-slim

# merge nginx configs from all services here
# `COPY` doesn't work if `CONFIG_SRC_FILES` holds multiple space-separated files, so we instead
# make a temporary bind of the dockerfile's context to `/tmp_bind/` inside the container and `cp`
# this does require us to mount a large context, but this service shouldn't be restarted much

ARG NGINX_CONFIG_SRC_FILES
RUN --mount=type=bind,target=/tmp_bind/ \
    if [ -n "${NGINX_CONFIG_SRC_FILES}" ]; then \
        cd /tmp_bind/ && cp -r ${NGINX_CONFIG_SRC_FILES} /etc/nginx/; \
    fi
