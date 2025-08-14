#!/bin/bash

# Script para configurar Firebase de forma segura
# Uso: ./setup_firebase.sh

set -e

echo "🔥 Configurando Firebase para Step Win App..."

# Verificar que exista el archivo de ejemplo
if [ ! -f "android/app/google-services.json.example" ]; then
    echo "❌ Error: No se encontró google-services.json.example"
    exit 1
fi

# Verificar que no exista ya el archivo real
if [ -f "android/app/google-services.json" ]; then
    echo "⚠️  El archivo google-services.json ya existe."
    read -p "¿Deseas sobrescribirlo? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Operación cancelada"
        exit 1
    fi
fi

# Solicitar credenciales
echo "📝 Ingresa las credenciales de Firebase:"
echo "   (Puedes encontrarlas en Firebase Console > Project Settings > General)"
echo

read -p "Project Number: " PROJECT_NUMBER
read -p "Project ID: " PROJECT_ID
read -p "Mobile SDK App ID: " MOBILE_SDK_APP_ID
read -p "OAuth Client ID: " OAUTH_CLIENT_ID
read -p "API Key: " API_KEY
read -p "iOS Client ID (opcional): " IOS_CLIENT_ID

# Crear el archivo con las credenciales
cp android/app/google-services.json.example android/app/google-services.json

# Reemplazar placeholders
sed -i "s/YOUR_PROJECT_NUMBER/$PROJECT_NUMBER/g" android/app/google-services.json
sed -i "s/YOUR_PROJECT_ID/$PROJECT_ID/g" android/app/google-services.json
sed -i "s/YOUR_MOBILE_SDK_APP_ID/$MOBILE_SDK_APP_ID/g" android/app/google-services.json
sed -i "s/YOUR_OAUTH_CLIENT_ID/$OAUTH_CLIENT_ID/g" android/app/google-services.json
sed -i "s/YOUR_API_KEY/$API_KEY/g" android/app/google-services.json

if [ ! -z "$IOS_CLIENT_ID" ]; then
    sed -i "s/YOUR_IOS_CLIENT_ID/$IOS_CLIENT_ID/g" android/app/google-services.json
fi

echo "✅ Archivo google-services.json configurado correctamente"
echo "⚠️  IMPORTANTE: Este archivo contiene credenciales sensibles y está excluido del control de versiones"
echo "📋 Para otros desarrolladores: ejecuta este script para configurar sus propias credenciales"