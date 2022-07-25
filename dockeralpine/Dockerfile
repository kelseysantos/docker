FROM alpine:latest

RUN apk update
RUN apk add bash bash-completion curl wget build-base

# RUN rm -rf /var/cache/apk/*

WORKDIR /app

ENTRYPOINT ["/bin/sh", "-l"]

CMD ["/bin/sh"]

# FROM centos:7.9.2009

# RUN yum update -y
# RUN yum install -y httpd
# RUN echo "Dockerfile Test on Aapche httpd" > /var/www/html/index.html

# EXPOSE 80
# CMD ["-D", "FOREGROUND"]
# ENTRYPOINT ["/usr/sbin/httpd"]