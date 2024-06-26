FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache wget

ARG TARGETOS
ARG TARGETARCH
ARG CONNECTOR_VERSION

RUN wget -P /tmp https://repo1.maven.org/maven2/io/debezium/debezium-connector-jdbc/${CONNECTOR_VERSION}/debezium-connector-jdbc-${CONNECTOR_VERSION}-plugin.tar.gz \
 && tar -xvf /tmp/debezium-connector-jdbc-${CONNECTOR_VERSION}-plugin.tar.gz -C /tmp \
 && mkdir -p /tmp/plugin && mv /tmp/debezium-connector-jdbc/*.jar /tmp/plugin/

# Define the entry point command
ENTRYPOINT [ "/bin/sh", "-c", "cp -r /tmp/plugin/ /opt/kafka/libs/connector-plugins/jdbc-debezium/" ]