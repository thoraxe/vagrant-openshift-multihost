#!/bin/bash
curl -u $SUB_USERNAME:$SUB_PASSWORD -k -v -X DELETE https://subscription.rhn.redhat.com/subscription/consumers/$1
