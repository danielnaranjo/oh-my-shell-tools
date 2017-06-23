#!/usr/bin/env bash

# ./utilidades.sh "descripcion" 1 1

NOTA=$1 # nota del commit, ej. cambios en logitnCtrl()
SOLOIONIC=$2 # Si/Yes = 1 No = 0
SOLOGITHUB=$3 # Si/Yes = 1 No = 0
COMMIT=$4 # Commit
FECHA="Rev $(date +'%d%m')" # Guarda el commit como Rev 2604

if [[ -z "$1" ]]; then
    NOTA="$(date +'%s')"
else
    NOTA=$1
fi

if [[ "$2" -eq 1 ]]; then
    echo "ionic upload --note '$FECHA $NOTA'"
    if ionic upload --note "$FECHA $NOTA" | grep -q COMMAND_FAILED ; then
        echo "#####"
        echo "ERROR: ionic upload --note '$FECHA $NOTA'"
        echo "#####"
        exit 1
    fi
else
    echo "Skipped ionic upload --note '$FECHA $NOTA'"
fi

if [[ "$3" -eq 1 ]]; then
    echo "git add ."
    if git add . | grep -q COMMAND_FAILED ; then
        echo "#####"
        echo "ERROR: git add ."
        echo "#####"
        exit 1
    fi
    echo "git commit -m '$FECHA $NOTA'"
    if git commit -m "$FECHA $NOTA" | grep -q COMMAND_FAILED ; then
        echo "#####"
        echo "ERROR: git commit -m '$FECHA $NOTA'"
        echo "#####"
        exit 1
    fi
else
    echo "Skipped git commit -m '$FECHA $NOTA'"
fi

if [[ "$4" -eq 1 ]]; then
    echo "git push origin master"
    if git push origin master | grep -q COMMAND_FAILED ; then
        echo "#####"
        echo "ERROR: git push origin master"
        echo "#####"
        exit 1
    fi
else
    echo "Skipped git push origin master"
fi
