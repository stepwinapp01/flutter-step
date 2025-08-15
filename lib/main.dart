import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

import 'features/coach/providers/chat_provider.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'shared/services/user_service.dart';
import 'shared/services/biometric_service.dart';
import 'features/auth/biometric_auth_screen.dart';

// Asumo estas rutas basado en la estructura del proyecto. Ajusta si es necesario.
import 'features/auth/google_auth_screen.dart';
import 'features/onboarding/simple_welcome_screen.dart';
import 'features/main_app/main_tabs_screen.dart';

/// Punto de entrada principal de la aplicación Step Win
/// Inicializa la aplicación con manejo de errores global
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase antes de correr la app para asegurar que los servicios
  // estén disponibles desde el principio.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Manejo de errores de Flutter
  FlutterError.onError = (FlutterErrorDetails details) {
    print('Flutter Error: ${details.exception}');
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step Win App',
      theme: AppTheme.lightTheme,

      // Configuración de internacionalización
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      // Configuración de debug
      debugShowCheckedModeBanner: false,

      home: const AuthGate(),
    );
  }
}

/// Un widget que actúa como guardián de autenticación.
///
/// Decide qué pantalla mostrar (onboarding o la app principal)
/// basándose en el estado de autenticación del usuario en Firebase.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Muestra un indicador de carga mientras se verifica el estado.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // Si el usuario está autenticado, verifica onboarding y biométrica
        if (snapshot.hasData) {
          return FutureBuilder<String>(
            future: _checkUserStatus(),
            builder: (context, statusSnapshot) {
              if (statusSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }
              
              switch (statusSnapshot.data) {
                case 'onboarding':
                  return const SimpleWelcomeScreen();
                case 'biometric':
                  return const BiometricAuthScreen();
                case 'dashboard':
                default:
                  return const MainTabsScreen();
              }
            },
          );
        }

        // Si no, muestra la pantalla de autenticación con Google.
        return const GoogleAuthScreen();
      },
    );
  }
  
  Future<String> _checkUserStatus() async {
    try {
      final hasCompletedOnboarding = await UserService.hasCompletedOnboarding();
      if (!hasCompletedOnboarding) {
        return 'onboarding';
      }
      
      // Verificar si la biométrica está disponible Y habilitada
      final biometricAvailable = await BiometricService.isBiometricAvailable();
      if (biometricAvailable) {
        // Verificar si el usuario ya se autenticó biométricamente en esta sesión
        final prefs = await SharedPreferences.getInstance();
        final biometricAuthDone = prefs.getBool('biometric_auth_done') ?? false;
        if (!biometricAuthDone) {
          return 'biometric';
        }
      }
      
      return 'dashboard';
    } catch (e) {
      print('Error checking user status: $e');
      // En caso de error, ir al dashboard si ya completó onboarding
      final hasCompletedOnboarding = await UserService.hasCompletedOnboarding();
      return hasCompletedOnboarding ? 'dashboard' : 'onboarding';
    }
  }
}