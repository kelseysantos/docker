FROM rockylinux:8

WORKDIR /redhat

RUN dnf update -y && \
    dnf install -y epel-release elrepo-release && \
    dnf upgrade -y && dnf clean all

RUN yum install -y bash curl wget nano vim && \
    yum install -y dnsmasq bind-utils && \
    systemctl enable dnsmasq

CMD [ "/usr/sbin/init" ]

# COPY start.sh start.sh
# CMD [ "/bin/bash", "start.sh" ]

# ENTRYPOINT [ "systemctl", "start", "dnsmasq"]