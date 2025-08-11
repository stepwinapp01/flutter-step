# 📱 Step Win App - Flujo de Pantallas

## 🎯 Pantallas Principales

### 1. **Onboarding Flow**
- `SplashScreen` → Pantalla de carga inicial
- `WelcomeScreen` → Selección de idioma (ES/EN)
- `AgeVerificationScreen` → Verificación de edad (16+ años)
- `LoginScreen` → OAuth Google + datos personales
- `FacialRecognitionScreen` → Reconocimiento facial (Nivel 2+)

### 2. **Setup Flow**
- `PlanSelectionScreen` → Planes (Basic $10, Pro $15, Elite $20)
- `PaymentScreen` → Stripe, USDT TRC20, USDC TRC20
- `DeviceConnectionScreen` → Google Fit, Apple Health, Fitbit, Garmin

### 3. **Main App (6 Tabs)**
- `HomeScreen` → Dashboard principal
- `GoalsScreen` → Metas diarias (pasos, sueño, agua, meditación)
- `RewardsScreen` → Tokens y retiros
- `ProgressScreen` → Niveles y estadísticas
- `CommunityScreen` → Feed del equipo
- `CoachAdanScreen` → Chat con IA

### 4. **Secondary Screens**
- `ProfileScreen` → Configuración de usuario
- `WithdrawalScreen` → Solicitar retiro USDT/USDC
- `KYCScreen` → Verificación para retiros >$100
- `TeamInviteScreen` → Invitar amigos con código
- `LevelDetailsScreen` → Detalles de niveles

## 🔄 Flujo de Navegación

```
Splash → Welcome → Age → Login → Facial → Plan → Payment → Device → MainTabs
                                    ↓
                              (Si ya registrado)
                                    ↓
                                MainTabs
```

## 📊 Estados de Usuario
- **Nuevo**: Onboarding completo
- **Registrado**: Directo a MainTabs
- **Nivel 2+**: Requiere reconocimiento facial
- **Retiro >$100**: Requiere KYC