FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add bash bash-completion curl wget build-base
RUN apk add kmod

# RUN apk add apache2

WORKDIR /app

# COPY index.html /var/www/localhost/htdocs/index.html

# VOLUME [ "XXXXXXXXXXXXXXXX" ]

#Rodar modo Debug caso não tenha uma aplicação rodando.
# COPY start.sh /start.sh
# RUN chmod +x /start.sh
# CMD [ "/start.sh" ]

# EXPOSE 80 443

#Colocar aqui o nome da aplicação para start do container.
# ENTRYPOINT [ "XXXXXXXX" ]

ENTRYPOINT ["tail", "-f", "/dev/null"]