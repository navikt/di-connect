#!/bin/bash

ENDPOINT="https://kafka-adminrest-q4.nais.preprod.local/api/v1/oneshot"

echo "Setter opp di-connect-offsets"
curl -X PUT \
    -H 'Content-type: application/json' \
    -u $USER -p \
    $ENDPOINT \
    -d @- << EOF
{
    "topics":[{
        "topicName":"di-connect-offsets",
        "numPartitions":25,
        "configEntries":{
            "retention.ms":"604800000",
            "cleanup.policy":"compact"
        },
        "members":[{
            "member":"srvdatavarehus",
            "role":"PRODUCER"
        },{
            "member": "srvdatavarehus",
            "role":"CONSUMER"
        }]
    }]
}
EOF
echo "\n"

echo "Setter opp di-connect-configs"
curl -X PUT \
    -H 'Content-type: application/json' \
    -u $USER -p \
    $ENDPOINT \
    -d @- << EOF
{
    "topics":[{
        "topicName":"di-connect-configs",
        "numPartitions":1,
        "configEntries":{
            "retention.ms":"604800000",
            "cleanup.policy":"compact"
        },
        "members":[{
            "member":"srvdatavarehus",
            "role":"PRODUCER"
        },{
            "member": "srvdatavarehus",
            "role":"CONSUMER"
        }]
    }]
}
EOF
echo "\n"


echo "Setter opp di-connect-status"
curl -X PUT \
    -H 'Content-type: application/json' \
    -u $USER -p \
    $ENDPOINT \
    -d @- << EOF
{
    "topics":[{
        "topicName":"di-connect-status",
        "numPartitions":25,
        "configEntries":{
            "retention.ms":"604800000",
            "cleanup.policy":"compact"
        },
        "members":[{
            "member":"srvdatavarehus",
            "role":"PRODUCER"
        },{
            "member": "srvdatavarehus",
            "role":"CONSUMER"
        }]
    }]
}
EOF
echo "\n"
