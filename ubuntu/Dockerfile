FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y && apt autoremove -y && apt install --no-install-recommends -y vim net-tools dnsutils
RUN apt install -y bash bash-completion base-files base-passwd adduser zip unzip nano iputils-ping
# RUN apt install -y build-essential
RUN apt install -y openssh-server curl ca-certificates wget

RUN rm -fr /var/lib/apt/lists/*

WORKDIR /app

ENTRYPOINT ["tail", "-f", "/dev/null"]