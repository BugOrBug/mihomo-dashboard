FROM docker.io/caddy:alpine

WORKDIR /srv
EXPOSE 100 101 102 103

RUN set -x \
    && apk update -f \
    && apk upgrade \
    && apk --no-cache add -f git \
    dcron \
    && rm -rf /var/cache/apk/* \
    && apk update \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

COPY crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab
RUN touch /var/log/cron.log

RUN git clone https://github.com/Zephyruso/zashboard.git -b gh-pages /srv/zashboard \
    && git clone https://github.com/metacubex/metacubexd.git -b gh-pages /srv/metacubexd \
    && git clone https://github.com/metacubex/Yacd-meta.git -b gh-pages /srv/yacd \
    && git clone https://github.com/metacubex/Razord-meta.git -b gh-pages /srv/razord

COPY Caddyfile .

CMD ["caddy", "run", "crond -f"]
