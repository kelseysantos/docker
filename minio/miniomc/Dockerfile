FROM alpine:latest

RUN apk update && apk upgrade \
    && apk add bash bash-completion curl wget \
    && rm -fr /var/cache/apk/*

RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc -O /usr/local/bin/mc \
    && chmod +x /usr/local/bin/mc \
    && curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron \
    && chmod u+x /usr/local/bin/go-cron

WORKDIR /app

ENTRYPOINT ["tail", "-f", "/dev/null"]