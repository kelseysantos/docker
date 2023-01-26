FROM ubuntu:latest

RUN apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt clean && \
    apt install --no-install-recommends -y apt-utils wget curl vim nano && \
    apt install --no-install-recommends -y net-tools dnsutils && \
    apt install --no-install-recommends -y openssh-server curl ca-certificates tini&& \
    # apt install --no-install-recommends -y bash bash-completion base-files base-passwd adduser zip unzip iputils-ping && \
    # apt install --no-install-recommends -y build-essential && \
    apt install -y init && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /ubuntu

CMD ["/sbin/init"]

#esse para debug
# ENTRYPOINT ["tail", "-f", "/dev/null"]