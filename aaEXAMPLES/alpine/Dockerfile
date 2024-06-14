FROM alpine:3.18.3

RUN apk update && apk upgrade \
    && apk add bash bash-completion curl wget build-base \
    && apk add kmod \
    && rm -fr /var/cache/apk/*

# Configuration for UBUNTU
# rm -fr /var/cache/apt/*
# apt install -y --no-install-recomends PACOTE

WORKDIR /app

# COPY index.html /var/www/localhost/htdocs/index.html

# VOLUME [ "/var/www/localhost/htdocs" ]

#Rodar modo Debug caso não tenha uma aplicação rodando.
# COPY start.sh /start.sh
# RUN chmod +x /start.sh
# CMD [ "/start.sh" ]

# EXPOSE 80 443

ENTRYPOINT ["tail", "-f", "/dev/null"]