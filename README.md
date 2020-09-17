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