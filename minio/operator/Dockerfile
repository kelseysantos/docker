FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y; apt upgrade -y; apt autoremove -y && \
    apt install --no-install-recommends -y vim bash bash-completion base-files libarchive-tools zip unzip nano && \
    apt install --no-install-recommends -y curl ca-certificates wget && \
    # apt install --no-install-recommends -y build-essential && \
    rm -fr /var/lib/apt/lists/*

WORKDIR /data

ENTRYPOINT ["tail", "-f", "/dev/null"]