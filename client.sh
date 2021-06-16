#!/usr/bin/env bash

# How's to
# Executable: chmod u+x client.sh 
# Modificable: chmod 640 client.sh 

echo " "
echo " * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
echo " *  Usage: "
echo " *  ./client.sh {customer} {environment} {optional: false}"
echo " *  "
echo " *  "

if [[ -z "$1" ]]; then
    echo " *  [ERROR] Customer is required, try: "
    echo " *  [ERROR] ./client.sh pax dev "
    echo " *  "
    echo " *  "
    echo " *  "
	exit 1
else
    CLIENT=$1
fi

if [[ -z "$2" ]]; then
    echo " *  [WARN] DEV as environment by default"
	ENVIRONMENT='dev'
else
    ENVIRONMENT=$2
fi

if [[ -z "$3" ]]; then
    echo " *  [INFO] Browser will open in a new tab / window by default"
    echo " *  [INFO] Attach adittional ng serve parameters like: --hmr (if it is available)"
	NEWTAB='-o'
else
    NEWTAB=$3
fi
echo " * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
echo " "
node angular-json-builder.js && ng serve -c $CLIENT-$ENVIRONMENT #$NEWTAB
echo " "
