# Docker Containers

Aplicações em Docker ![Docker](https://img.shields.io/github/stars/kelseysantos/docker?style=flat-square)

Projetos para aplicações em Docker.

# Dicas/Comandos Docker

 - Para instalar o Docker Compose, para verificar a versão atual, entrar neste [LINK](https://github.com/docker/compose/releases).
 ```shell
curl -L "https://github.com/docker/compose/releases/download/v2.28.1/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose;chmod +x /usr/local/bin/docker-compose
```
Caso não saiba qual a versão usar:
```shell
curl -L "https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;chmod +x /usr/local/bin/docker-compose
```
Versão para Linux Armv7 - Atualmente Storages **Asustor**
```shell
curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-linux-armv7" -o /usr/local/bin/docker-compose;chmod +x /usr/local/bin/docker-compose
```
Verificar os IPs dos Containers
```shell
docker inspect --format='{{ $n := .Name }}{{range .NetworkSettings.Networks}}{{ print .IPAddress "\t" $n "\n"}}{{end}}' $(sudo docker ps -q)
```
Verificar se o Container tem o healthcheck no código
```shell
docker ps --filter "health=none" --format '{{.ID}} \t {{.Names}}'
```
Verificar a Variável `TZ` dentro de um arquivo `*.yml`
```shell
find . -type f -name "docker-compose.yml" -exec grep -H "TZ=" {} \;
```
Deletar Imagens que não estão sendo usadas ou rodando
```shell
docker rmi $(docker images | cut -d 'R' -f 1 | cut -b 34-46)
```
Crie o arquivo **daemon.jon** caso não existir, e adicione as linas abaixo.
```shell
nano /etc/docker/daemon.json

# Add lines:

{
  "default-address-pools":
  [
    {"base":"10.10.0.0/16","size":24}
  ]
}
```
 - All containers without label "deunhealth.restart.on.unhealthy"
```
docker ps -aq | grep -v -E $(docker ps -aq --filter='label=deunhealth.restart.on.unhealthy' | paste -sd "|" -) | while read line ; do docker ps --filter "id=$line" --format "{{.Names}}"; done
```
 - All containers without label "deunhealth.restart.on.unhealthy" except the one named "deunhealth"
```
docker ps -aq | grep -v -E $(docker ps -aq --filter='label=deunhealth.restart.on.unhealthy' | paste -sd "|" -) | while read line ; do name=$(docker ps --filter "id=$line" --format "{{.Names}}") && if [[ $name != "deunhealth" ]]; then echo "$name"; fi; done
```
 - Verificar Vulnerabilidades na Imagem
```
grype bitnami/minio:latest
```
 - Para instalação do Grype no Linux.
 ```
 curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin 
 ```

### Instalar o Portainer para controle WEB de containers
 - Comando de docker run para executar o Portainer.
```
docker run --name container_portainer -d -p 8000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v volportanier:/data portainer/portainer-ce:latest
```

### Melhor Exemplo com MACVLAN no HOST:
 - A `rededocker` é o nome da interface criada de exemplo.
 - A interface física de exemplo é a `eno1` do HOST.
```
ip link add rededocker link eno1 type macvlan mode bridge
```
 - O Endereço de IP do HOST é o `10.100.100.65`, tem que especificar.
```
ip addr add 10.100.100.65/32 dev rededocker
```
 - Subir a interface `rededocker` para comunicação.
```
ip link set rededocker up
```
 - O range de IP à ser alcançado dos container são **10.100.100.97-126/255.255.255.224**, network: `10.100.100.96/27` rodando no HOST Hospedeiro.
```
ip route add 10.100.100.96/27 dev rededocker
```

### Apagar todos os volumes não utilizados
```shell
docker volume rm $(docker volume ls | cut -d R -f 1 | cut -b 11-200)
```
### Deletar as imagens não utilizadas do Docker
```shell
docker rmi $(docker images -aq)
```

#### Acessar container bash
 - Acessando o Container normalmente para executar um comando interno.
```shell
docker exec -it f9c42966a0b3 bash
```
 - Acessando o Container que está em execução como root no sintax **-uroot**, o exemplo: **f9c42966a0b3**.
```shell
docker exec -it -uroot f9c42966a0b3 bash
```
#### Configurar outra network para o DOKCER
 - Alterar a rede default redefinindo o range de IPs do Docker.
```shell
docker -v
# Docker version 23.0.1, build a5ee5b1
```
#### Limpar container e imagens não usadas
 - Limpando maquinas remotamente.
```
ssh 10.8.4.172 'docker system prune -f -a';ssh 10.8.4.173 'docker system prune -f -a';ssh 10.8.4.182 'docker system prune -f -a';ssh 10.8.4.183 'docker system prune -f -a'
```

 - Crie o arquivo **daemon.jon** caso não existir, e adicione as linas abaixo.
```shell
nano /etc/docker/daemon.json

# Add lines:

{
  "default-address-pools":
  [
    {"base":"10.10.0.0/16","size":24}
  ]
}
```
 - Restart o Serviço docker
```shell
systemctl restart docker
```
 - Verifique se a mudança deu certo
```shell
docker network inspect bridge | grep Subnet
```


#### Exemplo de default gateway interno e externo
```yaml
version: "3.9"

services:
  webserver:
    build:
      context: ./bin/${PHPVERSION}
    container_name: "${COMPOSE_PROJECT_NAME}-${PHPVERSION}"
    ...
    networks:
      - default    # network outside
      - internal   # network internal
  database:
    build:
      context: "./bin/${DATABASE}"
    container_name: "${COMPOSE_PROJECT_NAME}-${DATABASE}"
    ...
    networks:
      - internal   # network internal
#NETWORKs
networks:
  default:
    external: true
    name: nginx-proxy-man
  internal:
    internal: true
```
#### Certificados gerando pelo certbot
 - Gerando um certificado para o dominio servicos.cuiaba.br.
```
certbot certonly --manual --preferred-challenges=dns --email atendimento@servicos.cuiaba.br --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d *.servicos.cuiaba.br
certbot certificates
cat /etc/letsencrypt/live/servicos.cuiaba.br/fullchain.pem /etc/letsencrypt/live/servicos.cuiaba.br/privkey.pem > /etc/ssl/servicos.cuiaba.br.pem
ssl crt /etc/ssl/servicos.cuiaba.br.pemssl crt /etc/ssl/servicos.cuiaba.br.pem
```


## Docker CLI
**Executar Containers**

COMANDO | DESCRIÇÃO
---|---
`docker run IMAGEM` | Iniciar um novo container
`docker run --name CONTAINER IMAGEM` | Iniciar um novo container e atribuir um nome
`docker run -p PORTAHOST:PORTACONTAINER IMAGEM` | Iniciar um novo container com portas mapeadas
`docker run -P IMAGEM` | Iniciar um novo container e mapear todas as portas

**Gerenciamento de Containers:**

COMANDO | DESCRIÇÃO
---|---
`docker create IMAGEM` | Criar um novo container
`docker start CONTAINER` | Iniciar um container
`docker stop CONTAINER` | Parar um container com graça
`docker kill CONTAINER` | Encerrar (SIGKILL) um container
`docker restart CONTAINER` | Parar e reiniciar um container com graça
`docker pause CONTAINER` | Suspender um container
`docker unpause CONTAINER` | Retomar um container
`docker rm CONTAINER` | Destruir um container

**Gerenciamento em Lote de Containers**

COMANDO | DESCRIÇÃO
---|---
`docker stop $(docker ps -q)` | Parar todos os containers em execução
`docker stop $(docker ps -a -q)` | Parar todos os containers, tanto os em execução quanto os parados
`docker kill $(docker ps -q)` | Encerrar todos os containers em execução
`docker kill $(docker ps -a -q)` | Encerrar todos os containers, tanto os em execução quanto os parados
`docker restart $(docker ps -q)` | Reiniciar todos os containers em execução
`docker restart $(docker ps -a -q)` | Reiniciar todos os containers, tanto os em execução quanto os parados
`docker rm $(docker ps -q)` | Destruir todos os containers em execução
`docker rm $(docker ps -a -q)` | Destruir todos os containers, tanto os em execução quanto os parados
`docker pause $(docker ps -q)` | Pausar todos os containers em execução
`docker pause $(docker ps -a -q)` | Pausar todos os containers, tanto os em execução quanto os parados
`docker start $(docker ps -q)` | Iniciar todos os containers em execução
`docker start $(docker ps -a -q)` | Iniciar todos os containers, tanto os em execução quanto os parados
`docker rm -vf $(docker ps -a -q)` | Excluir todos os containers, incluindo seus volumes
`docker rmi -f $(docker images -a -q)` | Excluir todas as imagens
`docker system prune` | Excluir todas as imagens, containers, cache e volumes sem uso
`docker system prune -a` | Excluir todas as imagens utilizadas e não utilizadas
`docker system prune --volumes` | Excluir todos os volumes do Docker

**Inspecionar Containers:**

COMANDO | DESCRIÇÃO
---|---
`docker ps` | Listar containers em execução
`docker ps -a` | Listar todos os containers, incluindo os parados
`docker logs CONTAINER` | Mostrar a saída de um container
`docker logs -f CONTAINER` | Acompanhar a saída de um container
`docker top CONTAINER` | Listar os processos em execução em um container
`docker diff` | Mostrar as diferenças com a imagem (arquivos modificados)
`docker inspect` | Mostrar informações de um container (formato json)

**Executar Comandos:**

COMANDO | DESCRIÇÃO
---|---
`docker attach CONTAINER` | Anexar-se a um container
`docker cp CONTAINER:CAMINHO CAMINHOHOST` | Copiar arquivos do container para o host
`docker cp CAMINHOHOST CONTAINER:CAMINHO` | Copiar arquivos do host para o container
`docker export CONTAINER` | Exportar o conteúdo do container (arquivo tar)
`docker exec CONTAINER` | Executar um comando dentro de um container
`docker exec -it CONTAINER /bin/bash` | Abrir um shell interativo dentro de um container (em algumas imagens, não há bash, use /bin/sh)
`docker wait CONTAINER` | Aguardar até que o container seja encerrado e retornar o código de saída

**Imagens:**

COMANDO | DESCRIÇÃO
---|---
`docker images` | Listar todas as imagens locais
`docker history IMAGEM` | Mostrar o histórico da imagem
`docker inspect IMAGEM` | Mostrar informações (formato json)
`docker tag IMAGEM TAG` | Adicionar uma tag a uma imagem
`docker commit CONTAINER IMAGEM` | Criar uma imagem (a partir de um container)
`docker import URL` | Criar uma imagem (a partir de um arquivo tarball)
`docker rmi IMAGEM` | Excluir imagens
`docker pull REPO:[TAG]` | baixar uma imagem/repositório de um registro
`docker push REPO:[TAG]` | enviar uma imagem/repositório para um registro
`docker search TEXTO` | Pesquisar uma imagem no registro oficial
`docker login` | Fazer login em um registro
`docker logout` | Fazer logout de um registro
`docker save REPO:[TAG]` | Exportar uma imagem/repositório como arquivo tarball
`docker load` | Carregar imagens de um arquivo tarball

**Volumes:**

COMANDO | DESCRIÇÃO
---|---
`docker volume ls` | Listar todos os volumes
`docker volume create VOLUME` | Criar um volume
`docker volume inspect VOLUME` | Mostrar informações (formato json)
`docker volume rm VOLUME` | Destruir um volume
`docker volume ls --filter="dangling=true"` | Listar todos os volumes pendentes (não referenciados por

 nenhum container)
`docker volume prune` | Excluir todos os volumes não referenciados por nenhum container

### Backup de um container
Fazer backup dos dados do Docker de dentro dos volumes do container e empacotá-los em um arquivo tarball.
`docker run --rm --volumes-from CONTAINER -v $(pwd):/backup busybox tar cvfz /backup/backup.tar CAMINHODOCONTAINER`

Um backup automatizado também pode ser feito por meio deste [playbook Ansible](https://github.com/thedatabaseme/docker_backup).
A saída também é um arquivo tar (comprimido). O playbook também pode gerenciar a retenção do backup.
Portanto, backups antigos serão excluídos automaticamente.

Para também criar e fazer backup da configuração do container em si, você pode usar o `docker-replay` para isso. Se você perder
o container inteiro, você pode recriá-lo com a exportação do `docker-replay`.
Um tutorial mais detalhado sobre como usar o `docker-replay` pode ser encontrado [aqui](https://thedatabaseme.de/2022/03/18/shorty-generate-docker-run-commands-using-docker-replay/).

### Restaurar container a partir do backup
Restaurar o volume com um arquivo tarball.
`docker run --rm --volumes-from CONTAINER -v $(pwd):/backup busybox sh -c "cd CAMINHODOCONTAINER && tar xvf /backup/backup.tar --strip 1"`
## Redes

## Solução de Problemas
### Rede
`docker run --name netshoot --rm -it nicolaka/netshoot /bin/bash`
"


# Rede Social

Me pague um Café - https://www.buymeacoffee.com/kelseysantos<br>
![Youtube](https://img.shields.io/youtube/channel/subscribers/UCXS1xLbEwr12d97UyIEw6_w?style=social)<br>
![Twitter](https://img.shields.io/twitter/follow/kelseysantos?style=social)<br>
![GitHub](https://img.shields.io/github/followers/kelseysantos?style=social)<br>
![GitHubDownload](https://img.shields.io/github/downloads/kelseysantos/docker/total)

# Contatos

[![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/kelseysantos/)
[![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/kelseysantos)
[![Twitter](https://img.shields.io/badge/<handle>-%231DA1F2.svg?style=for-the-badge&logo=Twitter&logoColor=white)](https://twitter.com/kelseysantos)

## Autores
![KelseySantos](https://github.com/kelseysantos/pjcproduction/blob/main/screenshot/kelseysantos.png)