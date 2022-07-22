FROM centos:7.9.2009

ENV container=docker
ARG SAMBA_VERSION=4.16.3

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum update -y;yum -y install yum-plugin-priorities;yum -y install epel-release
RUN yum install -y supervisor tar unzip nano wget curl
RUN yum install -y iniparser libldb libtalloc libtdb libtevent python-devel gnutls-devel libacl-devel openldap-devel pam-devel readline-devel krb5-devel cups-devel
RUN yum groups -y install "Development Tools"

RUN yum clean all    

RUN wget https://download.samba.org/pub/samba/stable/samba-$SAMBA_VERSION.tar.gz
RUN tar -xvf samba-$SAMBA_VERSION.tar.gz 

VOLUME [ "/sys/fs/cgroup" ]
CMD [ "/usr/sbin/init" ]