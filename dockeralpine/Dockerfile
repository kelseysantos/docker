FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add bash bash-completion curl wget build-base

WORKDIR /app

COPY start.sh /start.sh

CMD [ "/start.sh" ]

# RUN rm -rf /var/cache/apk/*

# FROM centos:7.9.2009

# RUN yum update -y
# RUN yum install -y httpd
# RUN echo "Dockerfile Test on Aapche httpd" > /var/www/html/index.html

# EXPOSE 80
# CMD ["-D", "FOREGROUND"]
# ENTRYPOINT ["/usr/sbin/httpd"]