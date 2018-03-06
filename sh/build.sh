#!/bin/bash
docker build . -t fbrillon/nifi-rtmdemo
docker push fbrillon/nifi-rtmdemo
