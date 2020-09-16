#!/bin/bash

rm -rf *.zip
cp ../../../../kibana-extra/ingestion/build/ingestion-0.0.0.zip .
cp ../../../../kibana-extra/vega-timeline/build/vega-timeline-0.0.0.zip .
cp ../../../../kibana-extra/flights-scroll/build/flights-scroll-0.0.0.zip .

docker build -t kibana-opendistro-plugin-genius:0.10.0 --no-cache .