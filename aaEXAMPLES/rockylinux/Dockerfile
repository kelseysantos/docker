FROM rockylinux:8

WORKDIR /redhat

RUN dnf update -y && \
    dnf install -y epel-release elrepo-release && \
    dnf upgrade -y && dnf clean all && \
    dnf install -y bash curl wget nano vim

CMD [ "/usr/sbin/init" ]

# ENTRYPOINT [ "tail", "-f", "/dev/null"]