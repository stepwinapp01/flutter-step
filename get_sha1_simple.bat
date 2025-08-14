@echo off
chcp 65001 >nul
echo Obteniendo SHA-1 y SHA-256 del keystore de debug...
echo.

set KEYSTORE_PATH=%USERPROFILE%\.android\debug.keystore

if exist "%KEYSTORE_PATH%" (
    echo Keystore encontrado en: %KEYSTORE_PATH%
    echo.
    echo === HUELLAS DIGITALES PARA FIREBASE ===
    echo.
    keytool -list -v -keystore "%KEYSTORE_PATH%" -alias androiddebugkey -storepass android -keypass android | findstr "SHA1 SHA256"
    echo.
    echo === INSTRUCCIONES ===
    echo 1. Copia AMBAS huellas (SHA1 y SHA256)
    echo 2. Ve a Firebase Console ^> Project Settings ^> General
    echo 3. En "Your apps" selecciona tu app Android
    echo 4. En "SHA certificate fingerprints" agrega AMBAS huellas
    echo 5. Esto es necesario para SafetyNet y autenticacion por telefono
) else (
    echo No se encontro el keystore de debug en: %KEYSTORE_PATH%
    echo.
    echo Ejecuta primero: flutter run
    echo Esto generara el keystore automaticamente
)

echo.
pause