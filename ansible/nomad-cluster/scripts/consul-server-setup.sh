#!/bin/bash

function join_by { local d=${1-} f=${2-}; if shift 2; then printf %s "$f" "${@/#/$d}"; fi; }

SECRET=$1
DATACENTER=$2
ALL_INPUTS=(${@})
IPS=(${ALL_INPUTS[*]:2})

CONFIG_PATH="/etc/consul.d/config.json"
SERVICE_PATH="/etc/systemd/system/consul.service"

for i in "${!IPS[@]}"
do
   IPS[$i]="\"${IPS[$i]}\""
done

CONFIG = jq -n \
    --arg secret $SECRET \
    --arg datacenter $DATACENTER \
    --argjson ips $(join_by , $(echo [${IPS[*]}])) \
    '
{
    "bootstrap_expect": 3,
    "client_addr": "0.0.0.0",
    "datacenter": $datacenter,
    "data_dir": "/var/consul",
    "domain": "consul",
    "enable_script_checks": true,
    "dns_config": {
        "enable_truncate": true,
        "only_passing": true
    },
    "enable_syslog": true,
    "encrypt": $secret,
    "leave_on_terminate": true,
    "log_level": "INFO",
    "rejoin_after_leave": true,
    "server": true,
    "start_join": $ips,
    "ui": true
}'

echo $CONFIG > $CONFIG_PATH

echo <<EOF
[Unit]
Description=Consul Startup process
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash -c '/usr/local/bin/consul agent -config-dir /etc/consul.d/'
TimeoutStartSec=0

[Install]
WantedBy=default.target
EOF > $SERVICE_PATH

systemctl daemon-reload

systemctl start consul
