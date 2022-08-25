FROM alpine:latest

COPY start.sh /start.sh

RUN apk update && apk upgrade
RUN apk add iptables
RUN apk add bash-completion
RUN apk add kmod curl
RUN chmod +x /start.sh

CMD [ "/start.sh" ]