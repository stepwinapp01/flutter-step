# 🔒 Guía de Seguridad - Step Win App

## Configuración de Credenciales

### Firebase (CRÍTICO)

Las credenciales de Firebase **NO** deben estar en el control de versiones.

#### Configuración inicial:
```bash
# 1. Ejecutar script de configuración
./setup_firebase.sh

# 2. Seguir las instrucciones para ingresar credenciales
```

#### Para nuevos desarrolladores:
1. Obtener credenciales de Firebase Console
2. Ejecutar `./setup_firebase.sh`
3. Ingresar las credenciales cuando se soliciten

#### Archivos importantes:
- `android/app/google-services.json` - ❌ NO incluir en git
- `android/app/google-services.json.example` - ✅ Template sin credenciales
- `ios/Runner/GoogleService-Info.plist` - ❌ NO incluir en git

### Variables de Entorno

Para credenciales adicionales, usar variables de entorno:

```bash
# .env (NO incluir en git)
FIREBASE_API_KEY=tu_api_key_aqui
GOOGLE_SERVICES_KEY=tu_key_aqui
```

## Archivos Sensibles Excluidos

El `.gitignore` excluye automáticamente:
- Archivos de configuración de Firebase
- Keystores y certificados
- Archivos de build con información sensible

## Mejores Prácticas

1. **Nunca** commitear credenciales reales
2. Usar archivos `.example` para templates
3. Documentar el proceso de configuración
4. Rotar credenciales regularmente
5. Usar diferentes credenciales para desarrollo/producción

## Verificación de Seguridad

```bash
# Verificar que no hay credenciales en git
git log --all --full-history -- "*/google-services.json"

# Debe estar vacío o mostrar solo eliminaciones
```

## Contacto

Para reportar vulnerabilidades de seguridad, crear un issue privado o contactar al equipo de desarrollo.