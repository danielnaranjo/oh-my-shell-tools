#!/usr/bin/env bash

VERSION="$(date +'%d%m')" # Guarda el commit como Rev 26
HORA="$(date +"%H%M")" #17

PROYECTO="tuconsorcio"
APLICACION="tuconsorcio"
NOMBREARCHIVO=$APLICACION"_"$VERSION"_"$HORA".apk"
RUTASIGNER='"/c/Program Files/Java/jdk1.8.0_101/bin/"'
RUTAZIPPER="/c/Users/inacayal1/AppData/Local/Android/sdk/build-tools/25.0.0"
NOMBREKEYSTORE="inacayal"
PASSKEYSTORE="inacayal"
ALIASKEYSTORE="inacayal"

REGEX="0.[0-9].[0-9]"
CODE="0.$VERSION.$HORA"

clear
echo "clear"
clear
echo "******************************"
echo "Limpiar cache"
echo "cordova clean"
echo "******************************"
echo " "
cordova clean
echo "******************************"

if [[ -z "$1" ]]; then
    PERFIL=" --no-build --debug --device ZY2238D5J4"
    echo ".env > debug"
    echo "export const env = { production: false };" > src/configuracion/environment.ts
else
    PERFIL=" --prod --release"
    echo ".env > $PERFIL"
    echo "export const env = { production: true };" > src/configuracion/environment.ts
fi
PLATAFORMA="android" #ios or android
echo "******************************"

sed -i "2s/$REGEX/$CODE/g" config.xml
echo "******************************"

echo "Compilando version $CODE"
echo "******************************"

echo "ionic build $PLATAFORMA $PERFIL"
ionic cordova build $PLATAFORMA $PERFIL
echo "******************************"

echo "jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore"
"/c/Program Files/Java/jdk1.8.0_101/bin/"jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $NOMBREKEYSTORE.keystore -storepass $PASSKEYSTORE  ~/Documents/APP/$PROYECTO/platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk $ALIASKEYSTORE
echo "******************************"

echo "zipalign -v 4 "
/c/Users/inacayal1/AppData/Local/Android/sdk/build-tools/25.0.0/zipalign -v 4 platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk $NOMBREARCHIVO
echo "******************************"

echo "ls -la *.apk"
ls -lh *.apk
echo "******************************"
echo "Reset config.xml"
sed -i "2s/$CODE/0.0.0/g" config.xml
echo "******************************"

echo "adb devices"
adb devices
echo "******************************"

echo "adb install $NOMBREARCHIVO"
if adb install $NOMBREARCHIVO | grep -q INSTALL_FAILED_ALREADY_EXISTS ; then
    echo "adb uninstall ar.com.$PROYECTO"
    adb uninstall ar.com.$PROYECTO
    echo "******************************"
    echo "adb install $NOMBREARCHIVO"
    adb install $NOMBREARCHIVO
    echo "******************************"
fi
