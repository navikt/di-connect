FROM confluentinc/cp-kafka-connect:5.0.0

RUN apt-get update && \
    apt-get install -y nginx

ADD nginx.conf /etc/nginx/conf.d/connect.conf

ENV CONNECT_BOOTSTRAP_SERVERS "SASL_SSL://b27apvl00045.preprod.local:8443,SASL_SSL://b27apvl00046.preprod.local:8443,SASL_SSL://b27apvl00047.preprod.local:8443"
ENV CONNECT_REST_PORT "8084"
ENV CONNECT_GROUP_ID "di-connect-group-test"
ENV CONNECT_CONFIG_STORAGE_TOPIC "di-connect-configs"
ENV CONNECT_OFFSET_STORAGE_TOPIC "di-connect-offsets"
ENV CONNECT_STATUS_STORAGE_TOPIC "di-connect-status"
ENV CONNECT_KEY_CONVERTER "io.confluent.connect.avro.AvroConverter"
ENV CONNECT_KEY_CONVERTER_SCHEMA_REGISTRY_URL "http://kafka-schema-registry.tpa:8081/"
ENV CONNECT_VALUE_CONVERTER "io.confluent.connect.avro.AvroConverter"
ENV CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL "http://kafka-schema-registry.tpa:8081/"
ENV CONNECT_INTERNAL_KEY_CONVERTER "org.apache.kafka.connect.json.JsonConverter"
ENV CONNECT_INTERNAL_VALUE_CONVERTER "org.apache.kafka.connect.json.JsonConverter"
ENV CONNECT_REST_ADVERTISED_HOST_NAME "connect"
ENV CONNECT_LOG4J_ROOT_LOGLEVEL "INFO"
ENV CONNECT_LOG4J_LOGGERS "org.apache.kafka.connect.runtime.rest=WARN,org.reflections=ERROR"
ENV CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR "1"
ENV CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR "1"
ENV CONNECT_STATUS_STORAGE_REPLICATION_FACTOR "1"
ENV CONNECT_PLUGIN_PATH "/usr/share/java"
ENV CONNECT_SECURITY_PROTOCOL "SASL_SSL"
ENV CONNECT_SASL_MECHANISM "PLAIN"
ENV CONNECT_CONFIG_PROVIDERS "file"
ENV CONNECT_CONFIG_PROVIDERS_FILE_CLASS "org.apache.kafka.common.config.provider.FileConfigProvider"

ADD start.sh /root/start.sh

CMD ["/root/start.sh"]
