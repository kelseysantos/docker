FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y; apt upgrade -y; apt autoremove -y && \
    apt install --no-install-recommends -y vim net-tools dnsutils && \
    apt install --no-install-recommends -y bash bash-completion base-files base-passwd adduser zip unzip nano iputils-ping && \
    apt install --no-install-recommends -y openssh-server curl ca-certificates wget && \
    # apt install --no-install-recommends -y build-essential && \
    rm -fr /var/lib/apt/lists/*

WORKDIR /app

ENTRYPOINT ["tail", "-f", "/dev/null"]