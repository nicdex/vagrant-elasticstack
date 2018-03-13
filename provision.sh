#!/usr/bin/env bash
# Install dependencies
apt-get install -y software-properties-common python-software-properties
add-apt-repository -y ppa:openjdk-r/ppa
apt-get update
apt-get install -y openjdk-8-jre

# Configure limits
echo 'session required pam_limits.so' >> /etc/pam.d/common-session
echo 'session required pam_limits.so' >> /etc/pam.d/common-session-noninteractive
echo 'session required pam_limits.so' >> /etc/pam.d/login
sysctl -w fs.file-max=1000000
echo 'fs.file-max = 1000000' >> /etc/sysctl.conf
sysctl -w vm.max_map_count=1000000
echo 'vm.max_map_count = 1000000' >> /etc/sysctl.conf
echo 'vagrant hard nofile 1000000' >> /etc/security/limits.conf
echo 'vagrant soft nofile 1000000' >> /etc/security/limits.conf

# Creating logs dir
su - vagrant -c "mkdir logs"
# Install/configure ElasticSearch
su - vagrant -c "/vagrant/install_elasticsearch.sh"
# Install/configure Kibana
su - vagrant -c "/vagrant/install_kibana.sh"
