FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add bash bash-completion curl wget build-base
RUN apk add kmod

WORKDIR /app

#Rodar modo Debug caso não tenha uma aplicação rodando.
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD [ "/start.sh" ]

# EXPOSE 22

#Colocar aqui o nome da aplicação para start do container.
# ENTRYPOINT [ "XXXXXXXXX" ]