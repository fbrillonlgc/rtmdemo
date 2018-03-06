#!/bin/bash

docker run \
	--detach \
	--publish 8080-8081:8080-8081 \
	--mount type=bind,source=/lgc/share/,target=/lgc/share/,readonly \
	--mount type=bind,source=/lgc/nifi/,target=/lgc/nifi/ \
	--name nifi-rtmdemo \
	fbrillon/nifi-rtmdemo
