#!/usr/bin/env bash
VERSION="$(date +'%d%m')" # Guarda el commit como Rev 2604
HORA="$(date +"%H%M")" #1744

PROYECTO="pipol"
APLICACION="PipolUp"
NOMBREARCHIVO=$APLICACION"_"$VERSION"_"$HORA".apk"

RUTASIGNER="C:/Program Files/Java/jdk1.8.0_101/bin"
RUTAZIPPER="C:/Users/inacayal1/AppData/Local/Android/sdk/build-tools/25.0.0"
RUTAKEYSTORE="C:/Users/inacayal1/Documents/APP"

RUTAPROYECTO="C:/Users/inacayal1/Documents/APP"
RUTADESTINO="C:/Users/inacayal1/Documents/APP/$PROYECTO/$NOMBREARCHIVO"

NOMBREKEYSTORE=""
PASSKEYSTORE=""
ALIASKEYSTORE=""

PERFIL="--release" #debug or release
PLATAFORMA="android" #ios or android

clear
echo "******************************"
echo "* "
echo "* Build: $APLICACION ($PROYECTO) $VERSION $HORA $(date +'%T')"
echo "* "
echo "******************************"
sleep 3
echo "* "
echo "* cd pipol && ls -lh"
echo "* "
cd $PROYECTO
# if cd pipol | grep -q COMMAND_FAILED ; then
#     echo "ERROR: cd pipol "
#     exit 1;
# else
#    ls -l
    sleep 3
    # echo "******************************"
    # echo "* "
    # echo "* ionic build android"
    # echo "* "
    # if ionic build android | grep -q COMMAND_FAILED ; then
    #     echo "ERROR: ionic build android "
    #     return 1;
    # fi
#    ionic build android
    #ls -l
    echo "******************************"
    echo "* "
    echo "* ionic build $PLATAFORMA $PERFIL"
    echo "* "
    # if cordova build --release android | grep -q COMMAND_FAILED ; then
    #     echo "ERROR: cordova build --release android"
    #     return 1;
    # else
    ionic build $PLATAFORMA $PERFIL
        echo "******************************"
        echo "******************************"
#        echo "Cambiamos de ubicacion: cd $RUTASIGNER"
        # if cd "\Program Files\Java\jdk1.8.0_101\bin" | grep -q COMMAND_FAILED ; then
        #     echo "ERROR: cd '\Program Files\Java\jdk1.8.0_101\bin' "
        #     return 1;
        # else

        cd "$RUTASIGNER"
            #pwd
#            ls #-l jarsigner.*
            sleep 5
            echo "******************************"
            echo "* "
            echo "* Firmamos la App con jarSigner + keystore"
            echo "* "
            # if jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $NOMBREKEYSTORE.keystore -storepass $PASSKEYSTORE C:/Users/inacayal1/Documents/APP/$PROYECTO/platforms/android/build/outputs/apk/android-release-unsigned.apk $ALIASKEYSTORE | grep -q "command not found" ; then
            #     echo "ERROR: jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $NOMBREKEYSTORE.keystore "
            #     return 1;
            # fi
            # else
            #exit
            jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $NOMBREKEYSTORE.keystore -storepass $PASSKEYSTORE $RUTAPROYECTO/$PROYECTO/platforms/android/build/outputs/apk/android-release-unsigned.apk $ALIASKEYSTORE
            sleep 5
            echo "******************************"
            echo "* "
                echo "* Cambiamos de ubicacion: cd $RUTAZIPPER"
                echo "* "
                # if cd '\Users\inacayal1\AppData\Local\Android\sdk\build-tools\25.0.0' | grep -q COMMAND_FAILED ; then
                #     echo "ERROR: cd '\Users\inacayal1\AppData\Local\Android\sdk\build-tools\25.0.0'' "
                #     return 1;
                # else
                    cd "$RUTAZIPPER"
#                    ls #-l zipalign.*
                    sleep 5
                    echo "******************************"
                    echo "* "
                    echo "* Compilamos con zipalign"
                    echo "* "
                    $RUTAZIPPER/zipalign -v 4 $RUTAPROYECTO/$PROYECTO/platforms/android/build/outputs/apk/android-release-unsigned.apk $RUTAPROYECTO/$PROYECTO/$NOMBREARCHIVO
                    # if zipalign -v 4 android-release-unsigned.apk $NOMBREARCHIVO | grep -q COMMAND_FAILED ; then
                    #     echo "ERROR: zipalign -v 4 android-release-unsigned.apk '\Users\inacayal1\Documents\APP\pipol\PipolUp_$VERSION.apk"
                    #     return 1;
                    # else
                    echo "******************************"

                        #ls -l
                        sleep 5
                        echo "* "
                        echo "* Cambiamos la ubicacion: cd $RUTAPROYECTO/$PROYECTO"
                        echo "* "
                        # if cd '\Users\inacayal1\Documents\APP\pipol\' | grep -q COMMAND_FAILED ; then
                        #     echo "ERROR: cd '\Users\inacayal1\Documents\APP\pipol\' "
                        #     return 1;
                        # fi
                        cd "$RUTAPROYECTO/$PROYECTO"
                        echo "******************************"
#                     fi
#                 fi
#             fi
#         fi
#     fi
# fi
echo "* "
echo "* Completed $(date +'%T')"
echo "* "
echo "******************************"
ls -lh *.apk
#rm $APLICACION.apk
#mv $NOMBREARCHIVO $APLICACION.apk
echo "******************************"
echo "******************************"
# Uninstall current APK
#adb uninstall com.inacayal.pipol
# Install lastest APK
#adb install PipolUp.apk
# Descansa 30segs
#sleep 30
# Check logcat and save as..
#adb logcat -s "android_asset" > logcat.txt
# recolecta durante 1 min
#sleep 60
# salir
#exit
