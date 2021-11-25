# Zabbix-proxy 


## Introduction
Build a Debian/Ubuntu based image provisioned with Zabbix-proxy 5.0 and vault.
 

## Requirements

Install:
- packer
- python3
- pip3

Then run:
```bash
mkdir venv
python3 -m venv venv/
source venv/bin/activate
pip3 install -r requirements.txt
```


## Packer build variables
1. Create <b>variables.json</b>
```bash
vim variables.json
```

2. Use this template and add your values:
```bash
# vim variables.json
{
    "vcenter_server": "",
    "vcenter_username": "",
    "password": "",
    "template_name": "",
    "datastore": "",
    "folder": "",
    "cluster": "",
    "datacenter": "",
    "template_network": "",
    "iso_path": "",
    "packer_bastion_host": "",
    "packer_bastion_key": ""
}
```

## Zabbix settings
```bash
# vim playbooks/vars/main.yaml
---
# Agent related
zabbix_agent_become_on_localhost: false
zabbix_agent_version: 5.0
zabbix_agent_hostname: null
zabbix_agent_hostmetadata: proxy-hostmetadata
zabbix_agent_hostnameitem: system.hostname
zabbix_agent_server: "172.31.1.1"
zabbix_agent_serveractive: "172.31.1.1"

# Server related
zabbix_server_host: 172.31.1.1

# Proxy related
zabbix_proxy_version: 5.0
zabbix_proxy_database_long: sqlite3
zabbix_proxy_database: sqlite3
zabbix_proxy_dbhost_run_install: "True"
zabbix_proxy_dbname: /var/lib/sqlite/zabbix.db

# Active = 0 , Passive = 1
zabbix_proxy_mode: 0

# zabbix_proxy_hostname: null
zabbix_proxy_hostnameitem: system.hostname

zabbix_proxy_configfrequency: 300
zabbix_proxy_timeout: 30

zabbix_proxy_cachesize: 1024
zabbix_proxy_historycachesize: 64
zabbix_proxy_historyindexcachesize: 32

zabbix_proxy_fpinglocation: /usr/bin/fping
zabbix_proxy_fping6location: /usr/bin/fping6

zabbix_proxy_startvmwarecollector: 10
zabbix_proxy_vmwarefrequency: 60
zabbix_proxy_vmwarecachesize: 128

zabbix_proxy_startpollersunreachable: 5
zabbix_proxy_startpingers: 10
zabbix_proxy_starthttppollers: 3
zabbix_proxy_startpollers: 10
zabbix_proxy_startdiscoverers: 3

zabbix_proxy: null

# TLS
zabbix_proxy_tlsconnect: unencrypted
zabbix_proxy_tlsaccept: unencrypted

## Stuff to implement later on
#      zabbix_url: http://zabbix.example.com
#      zabbix_api_use: true # use zabbix_api_create_hosts and/or zabbix_api_create_hostgroup from 0.8.0
#      zabbix_api_user: Admin
#      zabbix_api_pass: zabbix
#      zabbix_create_host: present
#      zabbix_host_groups:
#        - Linux Servers
#      zabbix_link_templates:
#        - Template OS Linux
#        - Apache APP Template
#      zabbix_macros:
#        - macro_key: apache_type
#          macro_value: reverse_proxy
```

## Usage
Run following command to build image:
```bash
packer build -var-file="variables.json" build.json
```
