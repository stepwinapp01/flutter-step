@echo off
chcp 65001 >nul
echo Generando SHA-1 para Google Sign-In...
echo.

cd android
echo SHA-1 para DEBUG:
echo Ejecutando gradlew signingReport...
echo.
gradlew.bat signingReport

echo.
echo Busca en la salida anterior una linea similar a:
echo SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
echo.
echo Copia ese SHA-1 y agregalo en Firebase Console:
echo Project Settings ^> General ^> Your apps ^> Android app ^> SHA certificate fingerprints
echo.
pause