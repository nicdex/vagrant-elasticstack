#!/usr/bin/env bash
cd ~
echo 'Downloading and installing Kibana 6.2.2...'
wget -q https://artifacts.elastic.co/downloads/kibana/kibana-6.2.2-linux-x86_64.tar.gz
tar -xf kibana-6.2.2-linux-x86_64.tar.gz
password=$(grep "PASSWORD kibana" passwords.txt | cut -f4 -d" ")
cd kibana-6.2.2-linux-x86_64
echo 'Configuring Kibana...'
bin/kibana-plugin install x-pack -s
echo 'server.host: "0.0.0.0"' >> config/kibana.yml
echo 'elasticsearch.username: "kibana"' >> config/kibana.yml
echo 'elasticsearch.password: "'"$password"'"' >> config/kibana.yml
nohup bin/kibana > ../logs/kibana.log &
echo 'Waiting 4 minutes for Kibana to load...'
pause 240
password=$(grep "PASSWORD elastic" ../passwords.txt | cut -f4 -d" ")
echo 'You can login at http://localhost:5601 with elastic:$password'
