#!/usr/bin/env bash
#fecha="$(date +'%d%m%Y')"
fecha="$(date +'%T')"
# Cloud 1
# root
# root
# 127.0.0.1
# 5254

echo " "
echo " "
# parametros
# Primer: cuenta
# Segundo: servidor
# Tercer: puerto

if [[ -z "$1" ]]; then
    echo "ERROR: Es necesario definir la cuenta a exportar"
	exit 1
else
    cuenta=$1
fi

if [[ -z "$2" ]]; then
    echo "WARN: Servidor cloud1 por defecto"
    remoto=5254
else
    remoto=$2
fi

if [[ -z "$3" ]]; then
    echo "WARN: Puerto del Servidor cloud1 por defecto"
    puerto=5254
else
    puerto=$3
fi

echo "**************************************"
echo "Este script SOLO hace un backup de la carpeta /public_html/"
echo "Se debe hacer un backup de MySQL via phpMyAdmin o intentar"
echo "ejecutando MySQL dump desde la consola remota: "
echo "mysqldump -u <USUARIO> -p <PASSWORD> -h <HOST> -d <DATABASE>"
echo " "
echo "INFO: Inicio $fecha"
echo " "
echo "**************************************"
echo "INFO: ssh root@$remoto -p $puerto"
echo "**************************************"
if ssh root@$remoto -p $puerto | grep -q COMMAND_FAILED ; then
	echo "Error: No fue posible conectar con $remoto"
	exit 1
fi

# 1. conectar al servidor remoto 1 (ej. cloud1 /donweb)
# 2. acceder a la carpeta home, donde estan las cuentas (ej. pipol)
# 3. recorrer el directorio (ej. home)
# 4. comprimir cada contenido de public_html
# 5. copiar a servidor remoto 2 (ej. wnpower)

# Ideal seria que recorriera todo el directorio creando los archivos
# recorre el direcci
#for d in */; do
#    echo "$d"
#done

echo "**************************************"
# entro a la carpeta
echo "INFO: cd /home/$cuenta"
if cd /home/$cuenta | grep -q COMMAND_FAILED ; then
    echo "Error: No se pudo acceder a la cuenta: $cuenta"
    exit 1
fi
echo "**************************************"
# ls
# -a ocultos
# -l muestra como listado
# -h tamaño de archivos
echo "INFO: ls -lah"
if ls -lah | grep -q COMMAND_FAILED ; then
    echo "Error: No se pudo leer a la cuenta: $cuenta"
    exit 1
fi
echo "**************************************"
echo "INFO: tar -zcfp $cuenta$fecha.tar.gz public_html/"
# -v verbose
# -z compress
# -c create
# -f file
# -p permission
if tar -zcfp $cuenta$fecha.tar.gz public_html/ | grep -q COMMAND_FAILED ; then
    echo "Error: No se comprimir el achivo $cuenta.tar.gz"
    exit 1
fi
echo "**************************************"
# salgo de la carpeta actual
echo "INFO: cd .."
if cd .. | grep -q COMMAND_FAILED ; then
    echo "Error: No se pudo salir de la cuenta: $cuenta"
    exit 1
fi

echo "**************************************"
# salgo del servidor
echo "INFO: exit"
if exit | grep -q COMMAND_FAILED ; then
    echo "Error: No se pudo salir del servidor"
    exit 1
fi
echo "**************************************"
echo "INFO: Finalizado $fecha"
