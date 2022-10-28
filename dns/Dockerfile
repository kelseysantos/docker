FROM centos:7.9.2009

WORKDIR /centos

RUN yum update -y;yum upgrade -y

RUN yum install -y yum-plugin-priorities epel-release bash curl wget && \
    yum install -y dnsmasq

RUN systemctl enable dnsmasq;systemctl start dnsmasq

ENTRYPOINT [ "/bin/bash" ]