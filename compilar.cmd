SET PROYECTO=pipol
SET NOMBREARCHIVO=PipolUp_2206.apk
SET RUTAJAVA="C:/Program Files/Java/jdk1.8.0_101/bin"
SET RUTASIGNER="C:/Users/inacayal1/AppData/Local/Android/sdk/build-tools/25.0.0"
CLS
CD %PROYECTO%
DIR
ionic build android & cordova build --release android & CD %RUTAJAVA% & DIR & jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore inacayal.keystore -storepass inacayal & timeout 5 & C:/Users/inacayal1/Documents/APP/%PROYECTO%/platforms/android/build/outputs/apk/android-release-unsigned.apk inacayal & CD %RUTASIGNER% & zipalign -v 4 C:/Users/inacayal1/Documents/APP/%PROYECTO%/platforms/android/build/outputs/apk/android-release-unsigned.apk C:/Users/inacayal1/Documents/APP/%PROYECTO%/%NOMBREARCHIVO% & CD /Users/inacayal1/Documents/APP/%PROYECTO% & DIR *.APK
