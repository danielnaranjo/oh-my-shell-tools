#!/usr/bin/env bash
VERSION="$(date +'%d%m')" # Guarda el commit como Rev 2604
HORA="$(date +"%H%M")" #1744
PROYECTO="pipol"
APLICACION="PipolUp"
NOMBREARCHIVO=$APLICACION"_"$VERSION"_"$HORA".apk"
RUTAJAVA="\Program Files\Java\jdk1.8.0_101\bin"
RUTASIGNER="\Users\inacayal1\AppData\Local\Android\sdk\build-tools\25.0.0"

clear
echo "******************************************************************************************************************** "
echo "******************************************************************************************************************** "
echo "******************************************************************************************************************** "
echo "Build: $APLICACION ($PROYECTO) $VERSION $HORA $(date +'%T')"
echo "******************************************************************************************************************** "
echo "******************************************************************************************************************** "
echo "******************************************************************************************************************** "
echo "cd pipol && ls -lh"
cd "$PROYECTO"
# if cd pipol | grep -q COMMAND_FAILED ; then
#     echo "ERROR: cd pipol "
#     exit 1;
# else
    ls
    echo "******************************************************************************************************************** "
    echo "******************************************************************************************************************** "
    echo "******************************************************************************************************************** "
    echo "ionic build android"
    # if ionic build android | grep -q COMMAND_FAILED ; then
    #     echo "ERROR: ionic build android "
    #     return 1;
    # fi
    ionic build android
    #ls -l
    echo "******************************************************************************************************************** "
    echo "******************************************************************************************************************** "
    echo "******************************************************************************************************************** "
    echo "cordova build --release android"
    # if cordova build --release android | grep -q COMMAND_FAILED ; then
    #     echo "ERROR: cordova build --release android"
    #     return 1;
    # else
    cordova build --release android
        echo "******************************************************************************************************************** "
        echo "******************************************************************************************************************** "
        echo "******************************************************************************************************************** "
        echo "Cambiamos de ubicacion: cd $RUTAJAVA"
        # if cd "\Program Files\Java\jdk1.8.0_101\bin" | grep -q COMMAND_FAILED ; then
        #     echo "ERROR: cd '\Program Files\Java\jdk1.8.0_101\bin' "
        #     return 1;
        # else
        cd "$RUTAJAVA"
            #ls -l
            echo "******************************************************************************************************************** "
            echo "******************************************************************************************************************** "
            echo "******************************************************************************************************************** "
            echo "Firmamos jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore inacayal.keystore "
            # if jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore inacayal.keystore C:/Users/inacayal1/Documents/APP/pipol/platforms/android/build/outputs/apk/android-release-unsigned.apk inacayal | grep -q COMMAND_FAILED ; then
            #     echo "ERROR: jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore inacayal.keystore "
            #     return 1;
            # else

            jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore inacayal.keystore -storepass inacayal C:/Users/inacayal1/Documents/APP/$PROYECTO/platforms/android/build/outputs/apk/android-release-unsigned.apk inacayal
            echo "******************************************************************************************************************** "
            echo "******************************************************************************************************************** "
            echo "******************************************************************************************************************** "

                echo "Cambiamos de ubicacion: cd $RUTASIGNER"
                # if cd '\Users\inacayal1\AppData\Local\Android\sdk\build-tools\25.0.0' | grep -q COMMAND_FAILED ; then
                #     echo "ERROR: cd '\Users\inacayal1\AppData\Local\Android\sdk\build-tools\25.0.0'' "
                #     return 1;
                # else
                    cd "$RUTASIGNER"
                    #ls -l
                    echo "******************************************************************************************************************** "
                    echo "******************************************************************************************************************** "
                    echo "******************************************************************************************************************** "
                    echo "Compilamos con zipalign -v 4 android-release-unsigned.apk android.apk"
                    zipalign -v 4 C:/Users/inacayal1/Documents/APP/$PROYECTO/platforms/android/build/outputs/apk/android-release-unsigned.apk C:/Users/inacayal1/Documents/APP/$PROYECTO/$NOMBREARCHIVO
                    # if zipalign -v 4 android-release-unsigned.apk $NOMBREARCHIVO | grep -q COMMAND_FAILED ; then
                    #     echo "ERROR: zipalign -v 4 android-release-unsigned.apk '\Users\inacayal1\Documents\APP\pipol\PipolUp_$VERSION.apk"
                    #     return 1;
                    # else
                    echo "******************************************************************************************************************** "
                    echo "******************************************************************************************************************** "
                    echo "******************************************************************************************************************** "

                        #ls -l
                        echo "Cambiamos la ubicacion: cd \Users\inacayal1\Documents\APP\\$PROYECTO"
                        # if cd '\Users\inacayal1\Documents\APP\pipol\' | grep -q COMMAND_FAILED ; then
                        #     echo "ERROR: cd '\Users\inacayal1\Documents\APP\pipol\' "
                        #     return 1;
                        # fi
                        cd "\Users\inacayal1\Documents\APP\\$PROYECTO"
                        echo "******************************************************************************************************************** "
                        echo "******************************************************************************************************************** "
                        echo "******************************************************************************************************************** "
#                     fi
#                 fi
#             fi
#         fi
#     fi
# fi
echo "Completed $(date +'%T')"
echo "******************************************************************************************************************** "
echo "******************************************************************************************************************** "
echo "******************************************************************************************************************** "
ls -lh
