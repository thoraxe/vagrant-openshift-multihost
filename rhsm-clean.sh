#!/bin/bash
# first argument is the file to process
# the file should be the CSV file downloaded from the customer portal

perl -pi -e 's/\r\n/\n/' $1

for uuid in $(cat /tmp/rhsmexport.csv | grep example | cut -f3 -d, | tr -d '"')
do
  echo "Deleting $uuid..."
  curl -u $SUB_USERNAME:$SUB_PASSWORD -k -vvv -X DELETE "https://subscription.rhn.redhat.com/subscription/consumers/$uuid"
done
