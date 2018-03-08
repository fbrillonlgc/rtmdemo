FROM hortonworks/nifi

LABEL maintainer="francois.brillon@larochellegc.com"

# Setup working directory
USER nifi
RUN mkdir -p /home/nifi/lgc/rtmdemo/
WORKDIR /home/nifi/lgc/rtmdemo/

# Copy code
COPY --chown=nifi:nifi $SRC/java/rtmdemo/target/*.jar ./java/rtmdemo/target/
COPY --chown=nifi:nifi $SRC/sh/runetl.sh ./sh/
COPY --chown=nifi:nifi $SRC/nifi/ ./nifi/
COPY --chown=nifi:nifi $SRC/conf/rtmdemo.properties ./conf/

# Append nifi.properties
RUN cp $NIFI_HOME/conf/nifi.properties $NIFI_HOME/conf/nifi.properties.backup &&\
    cat $SRC/nifi/nifi.properties >> $NIFI_HOME/conf/nifi.properties
