FROM nginx:alpine-slim

# merge nginx configs from all services here
# `COPY` doesn't work if `CONFIG_SRC_FILES` holds multiple space-separated files, so we instead
# make a temporary bind of the dockerfile's context to `/tmp_bind/` inside the container and `cp`
# this does require us to mount a large context, but this service shouldn't be restarted much

ARG CONFIG_SRC_FILES

RUN --mount=type=bind,target=/tmp_bind/ \
    if [ -n "${CONFIG_SRC_FILES}" ]; then \
        cd /tmp_bind/ && cp -r ${CONFIG_SRC_FILES} /etc/nginx/; \
    fi
