FROM hortonworks/nifi

LABEL maintainer="francois.brillon@larochellegc.com"

# Setup working directory
USER nifi
RUN ln -s /opt/nifi/nifi-1.5.0.3.1.0.0-564/ /home/nifi/nifi &&\
    mkdir -p /home/nifi/lgc/rtmdemo/
WORKDIR /home/nifi/lgc/rtmdemo/

# Copy code
COPY --chown=nifi:nifi $SRC/java/rtmdemo/target/*.jar ./java/rtmdemo/target/
COPY --chown=nifi:nifi $SRC/sh/runetl.sh ./sh/
COPY --chown=nifi:nifi $SRC/nifi/flow.xml.gz ./nifi/
COPY --chown=nifi:nifi $SRC/nifi/rtmdemo.properties ./nifi/

# Update nifi properites
RUN cp /home/nifi/nifi/conf/nifi.properties /home/nifi/nifi.properties.backup &&\
    cp /home/nifi/nifi/conf/nifi.properties /home/nifi/nifi.properties &&\
    sed -i 's/nifi.flow.configuration.file=.\/conf\/flow.xml.gz/nifi.flow.configuration.file=\/home\/nifi\/lgc\/rtmdemo\/nifi\/flow.xml.gz/1' /home/nifi/nifi.properties &&\
    sed -i 's/nifi.variable.registry.properties=/nifi.variable.registry.properties=\/home\/nifi\/lgc\/rtmdemo\/nifi\/rtmdemo.properties/1' /home/nifi/nifi.properties &&\
    mv /home/nifi/nifi.properties /home/nifi/nifi/conf/nifi.properties
