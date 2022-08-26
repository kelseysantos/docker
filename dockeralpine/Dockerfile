FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add bash bash-completion curl wget build-base
RUN apk add kmod

WORKDIR /app

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD [ "/start.sh" ]