#!/bin/bash
set -e
docker build . -t fbrillon/nifi-rtmdemo
docker push fbrillon/nifi-rtmdemo
