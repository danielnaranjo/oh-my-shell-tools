#!/usr/bin/env bash
echo "### Cerrando session de ionic.io ###"
if rm -fr ~/.ionic/ | grep -q COMMAND_FAILED ; then
    echo " ERROR: Cerrando session de ionic.io"
    exit 1
fi
