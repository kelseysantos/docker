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

# Metube
 - Download de Vídeos do Youtube para Assistir Off-Line.
 
# PHPIPam
 - Gerenciamento de Networks

# Rocket CHAT
 - Comunicador de Comunidade ou Empresa.

# Heimdall
 - Bloco de Notas de Acesso a Sites.

# NGinx Proxy Reverso
 - Proxy Reverso.

# Unifi Controller Ubiquiti
 - Controlador de Roteadores Ubiquiti.

# JITSI MEET
 - Conferencia community para empresas.

# Vault Garden
 - Um sistema de cofre para guardar coisas que são sigilosas, como password, pastas de arquivos, bloco de anotações, etc.

# Final. Dicas/Comandos Docker

|   Nome    |   Comando |   Observação  |
|   -   |   -   |   -   |
| Compose | ``` sudo curl -L "https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose ``` | Atualização do Docker Compose para ultima versão https://github.com/docker/compose/releases/ |
|   Network |   ``` docker inspect --format='{{ $n := .Name }}{{range .NetworkSettings.Networks}}{{ print .IPAddress "\t" $n "\n"}}{{end}}' $(sudo docker ps -q) ```  |   Visualizar os IPs que os Container pegou    |
|   Health  |   ``` docker ps --filter "health=none" --format '{{.ID}} \t {{.Names}}'   ``` |   Verificar se o Container tem o healthcheck no código    |
|   Audit   |   ``` find . -type f -name "docker-compose.yml" -exec grep -H "TZ=" {} \; ``` |   Verificar a Variável `TZ` dentro de um arquivo `*.yml`  |
|   IMAGE   |   ``` docker rmi $(docker images | cut -d 'R' -f 1 | cut -b 34-46) ```    |   Deletar Imagens que não estão sendo usadas ou rodando  |


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