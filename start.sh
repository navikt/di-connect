#!/bin/sh

# Starting Nginx
service nginx start

# More Connect configuration
export CONNECT_SASL_JAAS_CONFIG="org.apache.kafka.common.security.plain.PlainLoginModule required \
username=\"${SRVDATAVAREHUS_USERNAME}\"\
password=\"${SRVDATAVAREHUS_PASSWORD}\";"
export CONNECT_SSL_TRUSTSTORE_LOCATION="${NAV_TRUSTSTORE_PATH}"
export CONNECT_SSL_TRUSTSTORE_PASSWORD="${NAV_TRUSTSTORE_PASSWORD}"

# Setting up Sink credentials
touch /var/run/secrets.properties
echo "username=${DATAVAREHUS_U1_USERNAME}
password=${DATAVAREHUS_U1_PASSWORD}
url=${DATAVAREHUS_U1_URL}" >> /var/run/secrets.properties

# Starting Kafka Connect
/etc/confluent/docker/run
