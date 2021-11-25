#!/bin/bash

vault_version="0.2.1"
vault_gateway_ip="10.1.4.10"
			
apt install python3-pip unzip -y

wget https://releases.hashicorp.com/vault-ssh-helper/${vault_version}/vault-ssh-helper_${vault_version}_linux_amd64.zip

unzip vault-ssh-helper_${vault_version}_linux_amd64.zip && \
 mv vault-ssh-helper /usr/bin/vault-ssh-helper && \
 chmod +x /usr/bin/vault-ssh-helper

cat <<EOF > /etc/pam.d/sshd 
auth requisite pam_exec.so quiet expose_authtok log=/tmp/vaultssh.log /usr/bin/vault-ssh-helper -config=/etc/ssh/vault.hcl
auth optional pam_unix.so not_set_pass use_first_pass nodelay
EOF
cat <<EOF > /etc/ssh/vault.hcl
vault_addr = "https://vault.domain.tld:8200"
ssh_mount_point = "ssh"
tls_skip_verify = false
allowed_roles = "*"
EOF

pip3 install yq

echo "$vault_gateway_ip vault.domain.tld" >> /etc/hosts

sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/UsePAM no/UsePAM yes/g' /etc/ssh/sshd_config
