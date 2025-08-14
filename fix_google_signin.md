# 🔧 Solución para Error Google Sign-In

## Error: `ApiException: 10` (DEVELOPER_ERROR)

### Pasos para solucionarlo:

1. **Obtener SHA-1 del certificado de debug:**
   ```bash
   # Ejecutar desde la raíz del proyecto
   get_sha1.bat
   ```

2. **Agregar SHA-1 en Firebase Console:**
   - Ve a Firebase Console > Project Settings > General
   - En "Your apps" selecciona tu app Android
   - En "SHA certificate fingerprints" haz clic en "Add fingerprint"
   - Pega el SHA-1 obtenido del paso 1

3. **Descargar nuevo google-services.json:**
   - En Firebase Console, descarga el archivo actualizado
   - Reemplaza `android/app/google-services.json`

4. **Verificar configuración OAuth:**
   - Ve a Google Cloud Console
   - APIs & Services > Credentials
   - Verifica que el OAuth 2.0 client tenga el SHA-1 correcto

5. **Limpiar y reconstruir:**
   ```bash
   flutter clean
   flutter pub get
   cd android && ./gradlew clean && cd ..
   flutter run
   ```

### Configuración adicional realizada:
- ✅ Agregados scopes específicos en GoogleSignIn
- ✅ Creado script para obtener SHA-1

### Notas importantes:
- El SHA-1 de debug es diferente al de release
- Cada desarrollador necesita agregar su propio SHA-1
- Para producción, usar el SHA-1 del keystore de release