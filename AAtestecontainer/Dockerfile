FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add bash bash-completion curl wget build-base
RUN apk add kmod openssh
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN adduser -h /home/kelsey -s /bin/sh -D kelsey
RUN echo -n 'kelsey:kelseysantos' | chpasswd

WORKDIR /app

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 22

CMD [ "/start.sh" ]