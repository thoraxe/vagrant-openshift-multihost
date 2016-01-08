#!/bin/bash
# cat /tmp/rhsmexport.csv | grep example | cut -f3 -d, | tr -d '"' | xargs ./rhsm-clean.sh
curl -u $SUB_USERNAME:$SUB_PASSWORD -k -vvv -X DELETE "https://subscription.rhn.redhat.com/subscription/consumers/$1"
