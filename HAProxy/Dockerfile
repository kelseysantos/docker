FROM rockylinux:9.1-minimal

WORKDIR /haproxy

RUN dnf update -y && \
    dnf install -y epel-release elrepo-release && \
    dnf upgrade -y && dnf clean all && \
    dnf install -y bash curl wget nano vim && \
    dnf install -y haproxy


