# Docker Containers

Aplicações em Docker ![Docker](https://img.shields.io/github/stars/kelseysantos/docker?style=flat-square)

## Projetos para aplicações em Docker.

### Dicas/Comandos Docker

 - Para instalar o Docker Compose, para verificar a versão atual, entrar neste [LINK](https://github.com/docker/compose/releases).
 ```shell
curl -L "https://github.com/docker/compose/releases/download/v2.36.0/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose;chmod +x /usr/local/bin/docker-compose
```
Caso não saiba qual a versão usar:
```shell
curl -L "https://github.com/docker/compose/releases/download/v2.36.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;chmod +x /usr/local/bin/docker-compose
```
Versão para Linux Armv7 - Atualmente Storages **Asustor**
```shell
curl -L "https://github.com/docker/compose/releases/download/v2.36.0/docker-compose-linux-armv7" -o /usr/local/bin/docker-compose;chmod +x /usr/local/bin/docker-compose
```
### Instalando o Kubectl e Helm
 - Para instalar o `kubectl` precisa executar os comando abaixo:
```shell
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && mv kubectl /usr/local/bin/ && chmod +x /usr/local/bin/kubectl
```
 - Helm - [LINK](https://helm.sh/docs/intro/install/)
```shell
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3;chmod 700 get_helm.sh;./get_helm.sh
```
### Converter Docker-Compose para Deployment Kubernetes
 - Ferramenta para conversão de docker-compose.yml para Deployment.yaml, link para versão: [LINK](https://github.com/kubernetes/kompose/releases/) - Para usar é somente executar o comando `kompose convert`, dentro da pasta onde está o docker-compose.yml. [FONTE](https://github.com/kubernetes/kompose).
```shell
curl -L https://github.com/kubernetes/kompose/releases/download/v1.31.1/kompose-linux-amd64 -o /usr/local/bin/kompose;chmod +x /usr/local/bin/kompose
```
### Install Kustomize Kubernetes
Para instalar o Kustomize copiar o comando abaixo: FONTE: [KUSTOMIZE](https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/)
```shell
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash && mv kustomize /usr/local/bin/
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
Comando direto, observe o ip colocado(base) e a mascara(size):
```shell
sh -c 'echo "{\n  \"default-address-pools\":\n  [\n    {\"base\":\"10.10.0.0/16\",\"size\":24}\n  ]\n}" > /etc/docker/daemon.json'
```
 - Restart o Serviço docker
```shell
systemctl restart docker
```
 - Verifique se a mudança deu certo
```shell
docker network inspect bridge | grep Subnet
```
 - All containers without label "deunhealth.restart.on.unhealthy"
```shell
docker ps -aq | grep -v -E $(docker ps -aq --filter='label=deunhealth.restart.on.unhealthy' | paste -sd "|" -) | while read line ; do docker ps --filter "id=$line" --format "{{.Names}}"; done
```
 - All containers without label "deunhealth.restart.on.unhealthy" except the one named "deunhealth"
```shell
docker ps -aq | grep -v -E $(docker ps -aq --filter='label=deunhealth.restart.on.unhealthy' | paste -sd "|" -) | while read line ; do name=$(docker ps --filter "id=$line" --format "{{.Names}}") && if [[ $name != "deunhealth" ]]; then echo "$name"; fi; done
```
 - Verificar Vulnerabilidades na Imagem
```shell
grype bitnami/minio:latest
```
 - Para instalação do Grype no Linux.
```shell
curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin 
```
### Instalar o Portainer para controle WEB de containers
 - Comando de docker run para executar o Portainer.
```shell
docker run --name container_portainer -d -p 8000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v volportanier:/data portainer/portainer-ce:latest
```
### Melhor Exemplo com MACVLAN no HOST:
 - A `rededocker` é o nome da interface criada de exemplo.
 - A interface física de exemplo é a `eno1` do HOST.
```shell
ip link add rededocker link eno1 type macvlan mode bridge
```
 - O Endereço de IP do HOST é o `10.100.100.65`, tem que especificar.
```shell
ip addr add 10.100.100.65/32 dev rededocker
```
 - Subir a interface `rededocker` para comunicação.
```shell
ip link set rededocker up
```
 - O range de IP à ser alcançado dos container são **10.100.100.97-126/255.255.255.224**, network: `10.100.100.96/27` rodando no HOST Hospedeiro.
```shell
ip route add 10.100.100.96/27 dev rededocker
```
### Healthcheck Default Docker-Compose
```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost"]
  interval: 30s
  timeout: 5s
  retries: 3
  start_period: 60s
```
### Volume Patch
Configuração do volume para salvar em um local específico.
```yaml
volumes:
  volportainer:
    name: volportainer
    driver: local
    driver_opts:
      type: none
      device: /mnt/volportainer
      o: bind
```
### Exemplo de default gateway interno e externo
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
### Deletar as imagens não utilizadas do Docker
```shell
docker rmi -f $(docker images -aq)
```
### Stop containers e remover todas as imagens e volumes
```shell
docker stop $(docker ps -a -q) && docker rm -vf $(docker ps -a -q)
```
### Acessar container bash
 - Acessando o Container normalmente para executar um comando interno.
```shell
docker exec -it f9c42966a0b3 bash
```
 - Acessando o Container que está em execução como root no sintax **-uroot**, o exemplo: **f9c42966a0b3**.
```shell
docker exec -it -uroot f9c42966a0b3 bash
```
### Certificados gerando pelo certbot
 - Gerando um certificado para o dominio servicos.cuiaba.br.
```
certbot certonly --manual --preferred-challenges=dns --email atendimento@servicos.cuiaba.br --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d *.servicos.cuiaba.br
certbot certificates
cat /etc/letsencrypt/live/servicos.cuiaba.br/fullchain.pem /etc/letsencrypt/live/servicos.cuiaba.br/privkey.pem > /etc/ssl/servicos.cuiaba.br.pem
ssl crt /etc/ssl/servicos.cuiaba.br.pemssl crt /etc/ssl/servicos.cuiaba.br.pem
```
### Exemplo MACVLAN com HOST:
 - A `rededocker` é o nome da interface criada de exemplo.
 - A interface física de exemplo é a `eno1` do HOST.
```shell
ip link add rededocker link eno1 type macvlan mode bridge
```
 - O Endereço de IP do HOST é o `10.100.214.54`, tem que especificar.
```shell
ip addr add 10.100.214.54/32 dev rededocker
```
 - Subir a interface `rededocker` para comunicação.
```shell
ip link set rededocker up
```
 - O range de IP à ser alcançado dos container são **10.100.214.97-126/255.255.255.224**, network: `10.100.214.96/27` rodando no HOST Hospedeiro.
```shell
ip route add 10.100.214.96/27 dev rededocker
```

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

### Docker CLI
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
`docker volume ls --filter="dangling=true"` | Listar todos os volumes pendentes (não referenciados por nenhum container)
`docker volume prune` | Excluir todos os volumes não referenciados por nenhum container

### Outros Comandos Rápidos
```shell
docker attach  – Acessar dentro do container e trabalhar a partir dele.
docker build   – A partir de instruções de um arquivo Dockerfile eu possa criar uma imagem.
docker commit  – Cria uma imagem a partir de um container.
docker cp      – Copia arquivos ou diretórios do container para o host.
docker create  – Cria um novo container.
docker diff    – Exibe as alterações feitas no filesystem do container.
docker events  – Exibe os eventos do container em tempo real.
docker exec    – Executa uma instrução dentro do container que está rodando sem precisar atachar nele.
docker export  – Exporta um container para um arquivo .tar.
docker history – Exibe o histórico de comandos que foram executados dentro do container.
docker images  – Lista as imagens disponíveis no host.
docker import  – Importa uma imagem .tar para o host.
docker info    – Exibe as informações sobre o host.
docker inspect – Exibe r o json com todas as configurações do container.
docker kill    – Da Poweroff no container.
docker load    – Carrega a imagem de um arquivo .tar.
docker login   – Registra ou faz o login em um servidor de registry.
docker logout  – Faz o logout de um servidor de registry.
docker logs    – Exibe os logs de um container.
docker port    – Abre uma porta do host e do container.
docker network – Gerenciamento das redes do Docker.
docker node    – Gerenciamento dos nodes do Docker Swarm.
docker pause   – Pausa o container.
docker port    – Lista as portas mapeadas de um container.
docker ps      – Lista todos os containers.
docker pull    – Faz o pull de uma imagem a partir de um servidor de registry.
docker push    – Faz o push de uma imagem a partir de um servidor de registry.
docker rename  – Renomeia um container existente.
docker restart – Restarta um container que está rodando ou parado.
docker rm      – Remove um ou mais containeres.
docker rmi     – Remove uma ou mais imagens.
docker run     – Executa um comando em um novo container.
docker save    – Salva a imagem em um arquivo .tar.
docker search  – Procura por uma imagem no Docker Hub.
docker service – Gernciamento dos serviços do Docker.
docker start   – Inicia um container que esteja parado.
docker stats   – Exibe informações de uso de CPU, memória e rede.
docker stop    – Para um container que esteja rodando.
docker swarm   – Clusterização das aplicações em uma orquestração de várias containers, aplicações junto.
docker tag     – Coloca tag em uma imagem para o repositorio.
docker top     – Exibe os processos rodando em um container.
docker unpause – Inicia um container que está em pause.
docker update  – Atualiza a configuração de um ou mais containers.
docker version – Exibe as versões de API, Client e Server do host.
docker volume  – Gerenciamento dos volumes no Docker.
docker wait    – Aguarda o retorno da execução de um container para iniciar esse container.
```

### Registry access
```yaml
{
  "insecure-registries" : ["10.8.4.61:5000"]
}
```


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