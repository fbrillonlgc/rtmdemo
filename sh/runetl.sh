#!/bin/bash
set -e
#if [ $# -ne 2 ];
#then
#  echo "Usage: runetl.sh"
#  echo "- Reads GTFS protocol buffer input and output in JSON formats"
#  exit -1
#fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
java -cp "$DIR/../java/rtmdemo/target/*" com.lgc.rtmdemo.App $* <&0
