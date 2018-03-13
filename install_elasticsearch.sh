#!/usr/bin/env bash
cd ~
echo 'Downloading and installing ElasticSearch v6.2.2...'
wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.2.2.tar.gz
tar -xf elasticsearch-6.2.2.tar.gz
cd elasticsearch-6.2.2
echo 'Configuring ElasticSearch...'
bin/elasticsearch-plugin install x-pack -b -s
echo 'network.host: 0.0.0.0' >> config/elasticsearch.yml
nohup bin/elasticsearch > ../logs/elasticsearch.log &
echo 'Waiting 2 minutes for ElasticSearch to load...'
sleep 120
bin/x-pack/setup-passwords auto -b > ../passwords.txt
