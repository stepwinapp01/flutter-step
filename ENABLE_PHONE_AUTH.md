# 🔧 Habilitar Autenticación por Teléfono en Firebase

## Error Actual
```
This operation is not allowed. This may be because the given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
```

## Solución - Pasos para Habilitar:

### 1. Ve a Firebase Console
- Abre https://console.firebase.google.com
- Selecciona tu proyecto: **stepwin-3f2c8**

### 2. Navega a Authentication
- En el menú lateral, haz clic en **Authentication**
- Ve a la pestaña **Sign-in method**

### 3. Habilita Phone Authentication
- Busca **Phone** en la lista de proveedores
- Haz clic en **Phone** 
- Cambia el toggle a **Enable**
- Haz clic en **Save**

### 4. Configurar SafetyNet (Opcional pero Recomendado)
- En la misma sección de Phone
- Agrega las huellas SHA-1 y SHA-256 si no están:
  - SHA-1: `2b37a7ecdd63fa2fca17db80fb0fff012df4725c`
  - SHA-256: (ejecuta get_sha1_simple.bat para obtenerla)

### 5. Verificar Configuración
- Asegúrate de que Phone aparezca como **Enabled**
- Guarda todos los cambios

## Después de Habilitar:
1. Ejecuta `flutter clean`
2. Ejecuta `flutter run`
3. Prueba la autenticación por SMS

## Nota Importante:
Firebase requiere que Phone Authentication esté explícitamente habilitada en la consola, incluso si tienes el código implementado correctamente.