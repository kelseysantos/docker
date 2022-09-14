FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add bash bash-completion curl wget build-base
RUN apk add kmod

# RUN apk add apache2

WORKDIR /app

# COPY index.html /var/www/localhost/htdocs/index.html

# VOLUME [ "/var/www/localhost/htdocs" ]

#Rodar modo Debug caso não tenha uma aplicação rodando.
# COPY start.sh /start.sh
# RUN chmod +x /start.sh
# CMD [ "/start.sh" ]

# EXPOSE 80 443

ENTRYPOINT ["tail", "-f", "/dev/null"]