FROM alpine:3.12

COPY scripts/run-cron /usr/local/bin/run-cron
COPY scripts/docker-entrypoint /docker-entrypoint

RUN set -eux; \
    mkdir -p /var/log/cron; \
    mkdir -m 0644 -p /var/spool/cron/crontabs; \
    touch /var/log/cron/cron.log; \
    mkdir -m 0644 /etc/cron.d; \
    chmod +x /usr/local/bin/run-cron
RUN chmod +x /docker-entrypoint

ENTRYPOINT [ "/docker-entrypoint" ]
CMD [ "tail", "-f", "/var/log/cron/cron.log" ]