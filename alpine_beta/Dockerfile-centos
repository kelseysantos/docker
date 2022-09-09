FROM centos:7.9.2009

RUN yum update -y
RUN yum install -y httpd
RUN echo "Test Kelsey Santos" > /var/www/html/index.html

EXPOSE 80
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]