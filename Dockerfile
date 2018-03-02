FROM hortonworks/nifi

LABEL maintainer="francois.brillon@larochellegc.com"

COPY $SRC/nifi/flow.xml.gz /conf/

RUN mkdir -p ./lgc/rtmdemo/
WORKDIR ./lgc/rtmdemo/

# Add ETL code
COPY $SRC/java/rtmdemo/target/*.jar ./java/
COPY $SRC/sh/runetl.sh ./sh/

#VOLUME /lgc/rtmdemo
