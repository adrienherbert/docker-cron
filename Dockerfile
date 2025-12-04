FROM alpine:latest
ENV SCRIPT_DIR=/cron-scripts
ENV CRON_FILE=/etc/crontabs/docker
RUN apk add --update --no-cache python3 py3-pip tini docker openrc bash coreutils
RUN rc-update add docker boot && adduser -S docker -D
COPY --chmod=755 ./bin/build-crontab /usr/local/bin/build-crontab
COPY --chmod=755 ./bin/docker-entrypoint /docker-entrypoint
ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint"]
CMD ["crond", "-f", "-d", "6", "-c", "/etc/crontabs"]
# CMD find / -name tini
# CMD find / -name docker-entrypoint

