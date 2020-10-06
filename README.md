# genius-opendistro
ELK opendistro sandbox. Tested on centos 7. Docker 19.03.12.

### Set up reverse proxy

* Install openresty
        
        cd src/main/openresty/
        chmod +x install.sh
        ./install.sh
        
* Check openresty status

        systemctl status openresty
        
* Set up proxy config
    
        systemctl stop openresty
        
1. Edit src/main/docker/nginx.conf
2. Change servername and IP
3. Restart openresty

        systemctl start openresty
        
4. Test proxy: https://server-ip:2376/test-tech


### Build Elastic image

1. Edit src/main/docker/elasticsearch/config.yml
2. Change IP for `openid_connect_url` setting
3. Build elasticsearch image
    
        cd src/main/docker/elasticsearch
        ./build.sh
        
### Build Kibana image

1. Edit src/main/docker/kibana/kibana.yml
2. Change IP for `opendistro_security.openid.connect_url` and `opendistro_security.openid.base_redirect_url` settings
3. Build kibana image
    
        cd src/main/docker/kibana
        ./build.sh        
        
### Start Elastic Kibana Keyclaok

        cd src/main/docker/
        docker-compose -f compose-keycloak-openresty.yaml up -d
        
### Test

1. Access keycloak: https://server-ip:2376/auth/
2. Create a user `user` with the role `kibana-user`


> You may have to regenerate a client_secret for keycloak

1. In keycloak, configure kibana client and regenerate client secret
2. Paste it in src/main/docker/kibana/kibana.yml
3. Rebuild kibana image
4. Restart compose file


> Access to kibana

1. Go to https://server-ip:2376/genius-kibana/
2. Log in with user `user`

---
# Installation ES opendistro

The installation has been made on CentOS 7.6.1810.

#### Download elasticsearch-oss 6.8.1
> Online

        wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-6.8.1.rpm

#### Download opendistro security plugin for elasticsearch 6.8.1
> Online

        wget https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-security/opendistro_security-0.10.0.0.zip

#### Install elasticsearch (on centos VM)
> Prerequisites : install java

        sudo yum clean all
        sudo yum install java-1.8.0-openjdk-headless -y

> Install ES

        sudo yum localinstall elasticsearch-6.8.1.rpm -y

#### Install opendistro security plugin and configure
> Answer yes if prompt

        cd /usr/share/elasticsearch
        sudo bin/elasticsearch-plugin install file://full/path/to/opendistro_security-0.10.0.0.zip

        cd /usr/share/elasticsearch/plugins/opendistro_security/tools
        sudo chmod +x install_demo_configuration.sh
        sudo ./install_demo_configuration.sh

> For testing, it's better to use http

Put in /usr/share/elasticsearch/config/elasticsearch.yml file:

        opendistro_security.ssl.http.enabled: false 

#### Start elasticsearch

        sudo systemctl daemon-reload
        sudo systemctl enable elasticsearch
        sudo systemctl start elasticsearch

> Test availability of ES

    curl -v https://localhost:9200/_cluster/health?pretty -u admin:admin
    
## Kibana opendistro with docker

> Use file

```
version: '3'
services:
  kibana:
    image: amazon/opendistro-for-elasticsearch-kibana:0.10.0
    ports:
      - 5601:5601
    expose:
      - "5601"
    environment:
      ELASTICSEARCH_URL: ChangeMe
      ELASTICSEARCH_HOSTS: ChangeMe
```

    
## Get all http request from kibana opendistro to ES opendistro

1) Connect to the VM where ES is installed
2) Install tcpflow

        sudo yum install tcpflow -y
        
3) Execute command to intercept packages on port 9200 on interface eth0

       sudo tcpflow -p -c -i eth0 port 9200 | grep -oE '(GET|POST|HEAD) .* HTTP/1.[01]'

Rq: ES basic (with xpack security) can't work with opendistro security plugin
    
---
