FROM hortonworks/nifi

LABEL maintainer="francois.brillon@larochellegc.com"

# Setup working directory
USER nifi
RUN mkdir -p /home/nifi/lgc/rtmdemo/
WORKDIR /home/nifi/lgc/rtmdemo/

# Copy code
COPY $SRC/java/rtmdemo/target/*.jar ./java/
COPY $SRC/sh/runetl.sh ./sh/
COPY $SRC/nifi/flow.xml.gz ./nifi/
