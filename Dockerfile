FROM hortonworks/nifi

LABEL maintainer="francois.brillon@larochellegc.com"

# Setup working directory
USER nifi
RUN mkdir -p /home/nifi/lgc/rtmdemo/
WORKDIR /home/nifi/lgc/rtmdemo/

# Copy code
COPY --chown=nifi:nifi $SRC/java/rtmdemo/target/*.jar ./java/
COPY --chown=nifi:nifi $SRC/sh/runetl.sh ./sh/
COPY --chown=nifi:nifi $SRC/nifi/flow.xml.gz ./nifi/
