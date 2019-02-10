#!/usr/bin/env bash

# A quick outline of the commands used to create tiles, upload to s3, and create Cloudfront Distributions

# I do not recommend running this file directly.

wget https://s3-us-west-2.amazonaws.com/misc-public-files-dt/simple_network.geojson

tippecanoe -e ./tiles -z9 --layer=network simple_network.geojson

aws s3 mb s3://faf-tiles

aws s3 sync ./tiles s3://faf-tiles --content-encoding gzip

aws s3api put-bucket-policy --bucket faf-tiles --policy file://s3-policy.json

aws s3api put-bucket-cors --bucket faf-tiles --cors-configuration file://s3-cors.json

aws cloudfront create-distribution --origin-domain-name faf-tiles.s3.amazonaws.com
