#!/usr/bin/env bash

# echo "Quieres descargar el archivo reciente?"
# select yn in "Yes" "No"; do
#     case $yn in
#         Yes ) make install; break;;
#         No ) exit;;
#     esac
# done

while true; do
    read -p "Quieres descargar el archivo reciente? " yn
    case $yn in
        [YySs]* ) read -p "Introduce el dominio/archivo a descargar: " dominio ; wget $dominio; break;;
        [Nn]* ) exit;;
        * ) echo "Debes seleccionar (Yes/No). En el caso de Yes debes copiar el dominio.ext/archivo.ext";;
    esac
done
