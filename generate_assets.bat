@echo off
REM Step Win App - Asset Generation Script (Windows)
REM Automatiza la generación de íconos, splash screen y favicon

echo 🚀 Iniciando generación de assets para Step Win App...

REM Verificar que estamos en el directorio correcto
if not exist "pubspec.yaml" (
    echo ❌ Error: No se encontró pubspec.yaml. Ejecuta desde la raíz del proyecto.
    pause
    exit /b 1
)

REM Obtener dependencias
echo 📦 Obteniendo dependencias...
flutter pub get

REM Generar íconos de la aplicación
echo 📱 Generando íconos de la aplicación...
flutter pub run flutter_launcher_icons:main
if %errorlevel% equ 0 (
    echo ✅ Íconos generados correctamente
) else (
    echo ❌ Error generando íconos
)

REM Generar splash screen
echo 🎨 Generando splash screen...
flutter pub run flutter_native_splash:create
if %errorlevel% equ 0 (
    echo ✅ Splash screen generado correctamente
) else (
    echo ❌ Error generando splash screen
)

REM Generar favicon (solo para web)
if exist "web" (
    echo 🌐 Generando favicon para web...
    if exist "favicon_generator.dart" (
        dart run favicon_generator.dart
        echo ✅ Favicon generado correctamente
    ) else (
        echo ⚠️ favicon_generator.dart no encontrado, saltando...
    )
) else (
    echo ℹ️ Directorio web no encontrado, saltando favicon...
)

REM Limpiar cache de Flutter
echo 🧹 Limpiando cache...
flutter clean
flutter pub get

echo.
echo ✅ ¡Todos los assets han sido generados exitosamente!
echo 📋 Resumen:
echo    - Íconos de aplicación: ✅
echo    - Splash screen: ✅
if exist "web" (
    echo    - Favicon web: ✅
) else (
    echo    - Favicon web: N/A
)
echo.
echo 🎯 Próximo paso: flutter build apk --release
pause