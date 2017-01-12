#!/usr/bin/env bash

docker run -i -v /etc/letsencrypt:/etc/letsencrypt -p 80:8090 -p 443:8091 -t shorts-salad /bin/bash