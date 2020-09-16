FROM amazon/opendistro-for-elasticsearch:0.10.0

ADD config.yml /usr/share/elasticsearch/plugins/opendistro_security/securityconfig/config.yml
#temporary fix
RUN chmod 777 /usr/share/elasticsearch/plugins/opendistro_security/securityconfig/config.yml
