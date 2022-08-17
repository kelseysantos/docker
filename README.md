Aplicações em Docker ![Docker](https://img.shields.io/github/stars/kelseysantos/docker?style=flat-square)
==================

Projetos para aplicações em Docker, lembrando que as redes aqui configuradas, são meramente ficticias não existentes.

# Minio 

https://dl.min.io/server/minio/release/linux-amd64/ <br>
https://docs.min.io/docs/minio-quickstart-guide.html

### Minio 1 Nodes

| NETWORK       | VLAN    | Nome VLAN   | HOSTNAME      | Endereço de IP  |
| - | - | - | - | - |
| 127.0.0.0/8   | bridge  | networkred  | miniomaster   | `dhcp`          | Acesso a Rede Externa   |
 - HardDisk = ./volumes/hd00

### Minio 4 Nodes Multinodes

| NETWORK       | VLAN    | Nome VLAN   | HOSTNAME      | Endereço de IP  |
| - | - | - | - | - |
| 127.0.0.0/8   | bridge  | networkred  | miniomaster   | `dhcp`          | Acesso a Rede Externa   |
| 10.1.10.0/24  | 10      | vlan10      | miniomaster   | `10.1.10.10`    | Acesso Local Rede 10    |
| 10.1.10.0/24  | 10      | vlan10      | minioslave0   | `10.1.10.11`    |
| 10.1.10.0/24  | 10      | vlan10      | minioslave1   | `10.1.10.12`    |
| 10.1.10.0/24  | 10      | vlan10      | minioslave2   | `10.1.10.13`    |
 - HardDisk = ./volumes/disk*

### Minio 3 Nodes With 36 Disk

| NETWORK       | VLAN    | Nome VLAN   | HOSTNAME      | Endereço de IP  |
| - | - | - | - | - |
| 127.0.0.0/8   | bridge  | networkred  | minio0   | `dhcp`          | Acesso a Rede Externa   |
| 10.1.10.0/24  | 10      | vlan10      | minio0   | `10.1.10.10`    | Acesso Local Rede 10    |
| 10.1.10.0/24  | 10      | vlan10      | minio1   | `10.1.10.11`    |
| 10.1.10.0/24  | 10      | vlan10      | minio2   | `10.1.10.12`    |
 - HardDisk = ./volumes/0*

# UrBackup Sistema de Backup

| NETWORK       | VLAN    | Nome VLAN   | HOSTNAME      | Endereço de IP  |
| - | - | - | - | - |
| 127.0.0.0/8   | bridge  | networkred  | urbackup   | `dhcp`          | Acesso a Rede Externa   |
 - HardDisk =   ./volumes/urbackup/varurbackup:/var/urbackup<br>
                ./volumes/urbackup/backups:/backups<br>
                ./volumes/urbackup/share:/usr/share/urbackup<br>
                ./volumes/urbackup/log:/var/log<br>

# Portainer CE Gerenciamento WEB

### Portainer para gerencimento web de container

| NETWORK       | VLAN    | Nome VLAN   | HOSTNAME      | Endereço de IP  |
| - | - | - | - | - |
| 127.0.0.0/8 |   bridge  |   NET_LOCAL   |   portainer   |   localhost   |
 - HardDisk =   /var/run/docker.sock:/var/run/docker.sock<br>
                volportainer:/data<br>

# Sonarqube
 - O SonarQube é a ferramenta líder para inspecionar continuamente a qualidade e a segurança do código de suas bases de código e orientar as equipes de desenvolvimento durante as revisões de código.

| NETWORK       | VLAN    | Nome VLAN   | HOSTNAME      | Endereço de IP  |
| - | - | - | - | - |
|   127.0.0.0/8   |   bridge  |   NET_LOCAL   |   sonarqube   |   localhost   |

# Redmine
 - Esta é a configuração mais simples para executar redmine. Ele está rodando com MySQL:Latest, em uma rede Docker interna.

| NETWORK       | VLAN    | Nome VLAN   | HOSTNAME      | Endereço de IP  |
| - | - | - | - | - |
|   10.100.212.0/24   |   maclan    |   NET_212   |   redmine   |   10.100.212.64   |
|   10.1.10.0/24   |   ipvlan   |   NET_DOCKER   |   redmine   |   10.1.10.3   |

# Budge
 - Aplicativo de finanças.

| NETWORK       | VLAN    | Nome VLAN   | HOSTNAME      | Endereço de IP  |
| - | - | - | - | - |
|   127.0.0.1/8 | host   |   host |   budge   |   localhost  |
 - HardDisk = ./budge/config:/config

# EmulatorJS
 - Emulador de Jogos Arcade no Browser.z

# Netboot XYZ
 - Seu sistema operacional preferido em um lugar.
 - https://netboot.xyz/

# Wireshark
 - Analizador de Redes

# Deluge
 - Client Torrent

# Emby Stream
 - Software para Stream Home Pessoal



# Final. Dicas/Comandos Docker

|   Nome    |   Comando |   Observação  |
|   -   |   -   |   -   |
|   Network |   ``` docker inspect --format='{{ $n := .Name }}{{range .NetworkSettings.Networks}}{{ print .IPAddress "\t" $n "\n"}}{{end}}' $(sudo docker ps -q) ```  |   Visualizar os IPs que os Container pegou    |
|   Health  |   ``` docker ps --filter "health=none" --format '{{.ID}} \t {{.Names}}'   ``` |   Verificar se o Container tem o healthcheck no código    |
|   Audit   |   ``` find . -type f -name "docker-compose.yml" -exec grep -H "TZ=" {} \; ``` |   Verificar a Variável `TZ` dentro de um arquivo `*.yml`  |


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

# NETWORK
 - Funcionamento da Rede MacVlan Docker no Linux, tem que colocar os seguintes comandos abaixo, onde o IP do host:`10.100.212.65/32` que está na rede `10.100.212.0/24`, tem que estar identificado. O nome que escolhi foi `rededocker` e depois fazer o roteamento da rede `10.100.212.0/24` (Geralmente a rede do meu roteador ou rede local) via a `rededocker`.
### macvlan
 - Para funcionar o MACVLAN no Linux
```
ip link add rededocker link eno1 type macvlan mode bridge;ip addr add 10.100.212.65/32 dev rededocker;ip link set rededocker up;ip route add 10.100.212.0/24 dev rededocker
```

# Sobre Docker Container

## Onde procurar ?
- [Moby](https://github.com/moby/moby)
- [Docker Images](https://hub.docker.com)
- [Docker Compose](https://github.com/docker/compose/) (Defina e execute aplicativos de vários contêineres com o Docker)
- [Docker Machine](https://github.com/docker/machine) (Gerenciamento de máquinas para um mundo centrado em contêineres)
- [Docker Registry][distribution] (O conjunto de ferramentas do Docker para empacotar, enviar, armazenar e entregar conteúdo)
- [Docker Swarm](https://github.com/docker/swarm) (Swarm: Um Docker-native clustering system)

## Infraestrutura e implantação

- [awesome-stacks](https://github.com/ethibox/awesome-stacks) - Implantação de 20+ aplicativos open-source para web com docker
- [blackfish](https://gitlab.com/blackfish/blackfish) - Um CoreOS VM na construção clusters swarm para Desenvolvimento e Produção [@blackfish](https://gitlab.com/blackfish/)
- [BosnD](https://gitlab.com/n0r1sk/bosnd) - BosnD, the boatswain daemon - A dynamic configuration file writer & service reloader for dynamically changing container environments.
- [Centurion](https://github.com/newrelic/centurion) - Centurion is a mass deployment tool for Docker fleets. It takes containers from a Docker registry and runs them on a fleet of hosts with the correct environment variables, host volume mappings, and port mappings. By [@newrelic](https://github.com/newrelic)
- [Clocker](https://github.com/brooklyncentral/clocker) - Clocker creates and manages a Docker cloud infrastructure. Clocker supports single-click deployments and runtime management of multi-node applications that run as containers distributed across multiple hosts, on both Docker and Marathon. It leverages [Calico][calico] and [Weave][weave] for networking and [Brooklyn](https://brooklyn.apache.org/) for application blueprints. By [@brooklyncentral](https://github.com/brooklyncentral)
- [Conduit](https://github.com/ehazlett/conduit) - Experimental deployment system for Docker by [@ehazlett](https://github.com/ehazlett)
- [depcon](https://github.com/ContainX/depcon) - Depcon is written in Go and allows you to easily deploy Docker containers to Apache Mesos/Marathon, Amazon ECS and Kubernetes. By [@ContainX][containx]
- [deploy](https://github.com/ttiny/deploy) :skull: - Git and Docker deployment tool. A middle ground between simple Docker composition tools and full blown cluster orchestration by [@ttiny](https://github.com/ttiny)
- [dockit](https://github.com/humblec/dockit) :skull: - Do docker actions and Deploy gluster containers! By [@humblec](https://github.com/humblec)
- [gitkube](https://github.com/hasura/gitkube) - Gitkube is a tool for building and deploying docker images on Kubernetes using `git push`. By [@Hasura](https://github.com/hasura/).
- [Grafeas](https://github.com/grafeas/grafeas) - A common API for metadata about containers, from image and build details to security vulnerabilities. By [grafeas](https://github.com/grafeas)
- [Longshoreman](https://github.com/longshoreman/longshoreman) :skull: - Longshoreman automates application deployment using Docker. Just create a Docker repository (or use a service), configure the cluster using AWS or Digital Ocean (or whatever you like) and deploy applications using a Heroku-like CLI tool. By [longshoreman](https://github.com/longshoreman)
- [SwarmManagement](https://github.com/hansehe/SwarmManagement) - Swarm Management is a python application, installed with pip. The application makes it easy to manage a Docker Swarm by configuring a single yaml file describing which stacks to deploy, and which networks, configs or secrets to create.
- [werf](https://github.com/werf/werf) - werf is a CI/CD tool for building Docker images efficiently and deploying them to Kubernetes using GitOps by [@flant](https://github.com/flant)


# Rede Social

![Youtube](https://img.shields.io/youtube/channel/subscribers/UCXS1xLbEwr12d97UyIEw6_w?style=social)<br>
![Twitter](https://img.shields.io/twitter/follow/kelseysantos?style=social)<br>
![GitHub](https://img.shields.io/github/followers/kelseysantos?style=social)<br>
![GitHubDownload](https://img.shields.io/github/downloads/kelseysantos/docker/total)

# Contatos

[![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/kelseysantos/)
[![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/kelseysantos)
[![Twitter](https://img.shields.io/badge/<handle>-%231DA1F2.svg?style=for-the-badge&logo=Twitter&logoColor=white)](https://twitter.com/kelseysantos)