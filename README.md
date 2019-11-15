# Check Twitter

## Descrição:
<br>Aplicação para análise de twitters a partir de uma hashtag
<br>Coleta os últimos 100 twitters dada uma determinada hashtag e armazenando essa informação em um bando de dados MariaDB
<br>Disponibiliza essas informações a partir de uma API REST

<br>Exibe em uma pagina web:
<br>Um sumario informando os 5 usuários das postagens que possuem mais seguidores
<br>A quantidade de postagens coletadas por hora
<br>Total de postagens por hashtags

## Monitoramento:
<br>Graylog para exibir logs referentes a consulta na API REST
<br>Zabbix para monitorar o tempo de resposta da API REST

## Instalação:
<br>O deploy é feito com ansible em uma cloud Openstack usado 2 instâncias.
<br>Instância app recebe a aplicação escrita em python3 junto com um contêiner de banco de dados
<br>Instância mon roda contêineres para o graylog e zabbix

Requerimentos para deploy
* Ansible: 2.8.5
* Clientes openstack

Carregar variáveis de ambiente openstack
```console
-> $ source openstackrc.sh
```
Criar uma variável shell contendo o caminho da chave privada usada nas conexões ssh com as instancias
```console
-> $ KEY_FILE=~/.ssh/chave.pem
```
<br>Preencher variaves do ansible como exemplo em:
```console
-> $ vim playbooks/group_vars/all.yml
```

```console
meu_ip: IpDeOrigem                              # http://meuip.com
rede_interna: 192.168.0.0/24                    # rede comunicacao interna

keystone_url: https://keystone.domain:5000/v2.0 # grep AUTH_URL= openstackrc
tenant_name: Tenand_name                        # grep TENANT_NAME= openstackrc
region_name: reg_name                           # grep REGION_NAME= openstackrc
image_id: ID_image                              # glance image-list | grep -i centos
ssh_key_name: "name_key"                        # openstack keypair list 
net_id: ID_net                                  # neutron net-list
availability_zone: reg_name_zone                # openstack availability zone list
domain: cloud.twr

# user: admin
# pass: admin
graylog_root_pass_sha2: 8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918

root_db_pass: passRoot

# Habilitar modo desenvolvedor no twitter
# Criar um app com token
# https://developer.twitter.com/en/apps/
consumer_key: 'sdfsetrerterter'
consumer_secret: 'tretfdfgdfgd'

token_key: 'sdfsfsfds'
token_secret: 'gfhghghfhg'
```

Executar playbook up:
```console
-> $ ansible-playbook playbooks/up.yml -u administrator --extra-vars \
	"tenant_password=$OS_PASSWORD tenant_username=$OS_USERNAME" \
	--key-file=$KEY_FILE
```
## Video de demonstração
[![Demonstração de Deploy em OpenStack](http://img.youtube.com/vi/Qx9xhEroN68/0.jpg)](http://www.youtube.com/watch?v=Qx9xhEroN68 "Video de demostração")
