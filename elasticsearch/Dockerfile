FROM rockylinux:9.0

WORKDIR /elastic

RUN dnf update -y && \
    dnf install -y epel-release elrepo-release && \
    dnf upgrade -y && dnf clean all && \
    yum install -y bash curl wget nano vim
    # yum install -y dnsmasq bind-utils

# RUN systemctl enable --now elasticsearch

# EXPOSE 53

# VOLUME [ "/etc/dnsmasq.conf" ]

CMD [ "/usr/sbin/init" ]
# ENTRYPOINT [ "tail", "-f", "/dev/null"]