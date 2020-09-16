FROM amazon/opendistro-for-elasticsearch-kibana:0.10.0

USER root

ADD kibana-docker /usr/local/bin/kibana-docker

ADD kibana.yml /usr/share/kibana/config/kibana.yml

RUN chown kibana:root /usr/local/bin/kibana-docker && chmod 755 /usr/local/bin/kibana-docker

RUN chown kibana:root /usr/share/kibana/config/kibana.yml && chmod 755 /usr/share/kibana/config/kibana.yml

COPY *.zip /

RUN ./bin/kibana-plugin install file:///ingestion-0.0.0.zip --no-optimize && \
    ./bin/kibana-plugin install file:///vega-timeline-0.0.0.zip --no-optimize && ./bin/kibana-plugin install file:///flights-scroll-0.0.0.zip --no-optimize

USER kibana