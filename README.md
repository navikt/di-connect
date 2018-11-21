di-connect
==========

DI sin egen Kafka Connect


## Opp og kjøre i NAIS

Før vi deployer Connect på NAIS-plattformen trenger vi å ha laget tre topics: `di-connect-offsets`, `di-connect-configs`, `di-connect-setup`. For å gjøre prosessen enklere har vi lagd scriptet `init_topics.sh`. Dette enkle scriptet kjører tre kall mot `kafka-adminrest`, et per topic vi trenger.


### Deployment

Sett passord med:
```bash
read -s -p "Password: " PASSWORD
```

```bash
curl -v --fail -k -d '{"application": "datavarehus", "version": "<version>", "fasitEnvironment": "q0", "zone": "fss", "fasitUsername": "'"$USER"'", "fasitPassword": "'"$PASSWORD"'", "namespace": "default", "manifesturl": "https://raw.githubusercontent.com/navikt/di-connect/master/nais.yaml"}' https://daemon.nais.preprod.local/deploy
```


### Post sink

```bash
curl -X POST https://datavarehus.nais.preprod.local/connectors \
     -H 'Content-Type: application/json' \
     -H 'Accept: application/json' \
     -d @- << EOF
{
  "name": "aapen-oppgave-4",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
    "table.name.format": "fk_p.oppgave_json_dump",
    "topics": "aapen-oppgave-opprettet-v1-preprod",
    "tasks.max": "1",
    "auto.create": "true",
    "auto.evolve": "true",
    "connection.password": "\${file:/var/run/secrets.properties:password}",
    "connection.user": "\${file:/var/run/secrets.properties:username}",
    "connection.url": "\${file:/var/run/secrets.properties:url}"
  }
}
EOF
```


### Send message

```bash
curl -X POST https://oppgave.nais.preprod.local/api/v1/oppgaver \
     -H 'Content-type: application/json' \
     -H 'Accept: application/json' \
     -H 'X-Correlation-ID: 123' \
     -H 'Authorization: Basic <base64>' \
     -d @- << EOF
{
   "tildeltEnhetsnr": "0118",
   "opprettetAvEnhetsnr": "0118",
   "behandlesAvApplikasjon": "FS22",
   "saksreferanse": "84942299",
   "tilordnetRessurs": "Z990695",
   "beskrivelse": "heio",
   "tema": "AAR",
   "oppgavetype": "BEH_HENV",
   "behandlingstema": "ab0002",
   "fristFerdigstillelse": "2018-11-11",
   "aktivDato": "2018-03-10",
   "prioritet": "HOY",
   "metadata": {}
}
EOF
```
