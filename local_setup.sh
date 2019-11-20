#!/bin/bash
graylog_root_pass_sha2='6395b16fdf5e44b86ea6f1638c02e39a31f97a07285293eaf786c99d7f41002e'
local_ip=$(ip a s $(ip r s | grep default | awk '{print $5}') | grep ' inet ' | awk '{print $2}' | cut -d \/ -f1)

[ ! -d /tmp/docker-compose ] && mkdir -p /tmp/docker-compose

graylog(){
	echo "Deploy graylog"
	cp -r roles/graylog-docker/templates/ /tmp/docker-compose/graylog/
	sed -i "s/{{ graylog_root_pass_sha2 }}/$graylog_root_pass_sha2/g" \
		/tmp/docker-compose/graylog/docker-compose.yml

	sed -i "s/{{ ansible_ssh_host }}/$local_ip/g" \
		/tmp/docker-compose/graylog/docker-compose.yml

	cd /tmp/docker-compose/graylog && docker-compose up -d && cd -
}

zabbix(){
	echo "Deploy zabbix"
	git clone https://github.com/zabbix/zabbix-docker.git /tmp/docker-compose/zabbix/
	cp /tmp/docker-compose/zabbix/docker-compose_v3_alpine_pgsql_latest.yaml \
		/tmp/docker-compose/zabbix/docker-compose.yml

	sed -i "s/# PHP_TZ=Europe\/Riga/PHP_TZ=America\/Sao_Paulo/g" \
		/tmp/docker-compose/zabbix/.env_web

	sed -i "s/ZBX_SERVER_NAME=Composed installation/ZBX_SERVER_NAME=Check Twitter Local/g" \
		/tmp/docker-compose/zabbix/.env_web

	cd /tmp/docker-compose/zabbix/ && docker-compose up -d && cd -
}

cleanup(){
	[ -d /tmp/docker-compose/graylog ] && \
		cd /tmp/docker-compose/graylog && \
		docker-compose down && cd

	[ -d /tmp/docker-compose/zabbix ] && \
		cd /tmp/docker-compose/zabbix && \
		docker-compose down && cd

	[ -d /tmp/docker-compose ] && \
		sudo rm -rf /tmp/docker-compose
}

msg_padrao="
\nflag padrao, valores aceitaveis:
\n --zabbix
\n --graylog
\n --clear
"
while test -n "$1"
do
	case $1 in
		--zabbix) zabbix ;;
		--graylog) graylog ;;
		--clear) cleanup ;;
		-v | --version) echo "flag -v ou --version" ;;
		*) echo -e $msg_padrao
	esac
	shift
done
