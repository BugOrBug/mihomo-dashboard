FROM docker.io/caddy:alpine

WORKDIR /srv
EXPOSE 100 101 102 103

RUN apk update && apk upgrade \
    && apk add --no-cache \
        dcron \
        tzdata \
        git \
    && rm -rf /tmp/* /var/cache/apk/*
    
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

RUN mkdir -p /etc/cron.d \
    && touch /var/log/cron.log

COPY crontab /etc/cron.d
RUN crontab /etc/cron.d/crontab \
    && chmod 0644 /etc/cron.d/crontab

RUN git clone https://github.com/Zephyruso/zashboard.git -b gh-pages /srv/zashboard \
    && git clone https://github.com/metacubex/metacubexd.git -b gh-pages /srv/metacubexd \
    && git clone https://github.com/metacubex/Yacd-meta.git -b gh-pages /srv/yacd \
    && git clone https://github.com/metacubex/Razord-meta.git -b gh-pages /srv/razord

COPY Caddyfile .

CMD ["caddy", "run", "crond -f"]
