
REM http://steve-jansen.github.io/guides/windows-batch-scripting/part-8-parsing-input.html
SET filepath=%dp0

REM Accesing to ADB server (I have a symbolic link to: C:\Users\Me\AppData\Local\Android\sdk )
cd \devices

REM List od devices connected
adb devices

REM install API from defaul output folder by Ionic Framework
adb install filepath

REM adb kill-server && adb start-server