#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo "ERROR: ENTER A IP ADDRESS OR DOMAIN TO CHECK"
	exit 1
else
    cuenta=$1
fi
echo "**************************************"
echo " "
echo "INFO: START $(date +'%T')"
echo " "
echo "**************************************"
echo " "
echo "INFO: ping $cuenta"
if ping $cuenta | grep -q COMMAND_FAILED ; then
    echo "ERROR: CAN NOT PING IT"
    exit 1
fi
sleep 5
echo " "
echo "**************************************"
echo " "
echo "INFO: nslookup -type=any $cuenta"
if nslookup -type=any $cuenta | grep -q COMMAND_FAILED ; then
    echo "ERROR: CAN NOT NS LOOKUP"
    exit 1
fi
sleep 5
echo " "
echo "**************************************"
echo " "
echo "INFO: curl $cuenta"
if curl $cuenta | grep -q COMMAND_FAILED ; then
    echo "ERROR: CAN NOT CURL IT"
    exit 1
fi
sleep 5
echo " "
echo "**************************************"
echo "INFO: FINISHED $(date +'%T')"
