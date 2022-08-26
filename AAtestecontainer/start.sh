#!/bin/bash
#######################################################################################
# kelseysantos.blogspot.com - contato:kelseysantos@yahoo.com.br
# Data Ultima Atualizacao: 20220826
#######################################################################################

ssh-keygen -A
exec /usr/sbin/sshd -D -e "$@"

while [ true ]; do
    sleep 3600;
done