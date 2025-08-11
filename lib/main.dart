import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'features/auth/google_auth_screen.dart';
import 'features/coach/providers/chat_provider.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'core/utils/logger.dart';

/// Punto de entrada principal de la aplicación Step Win
/// 
/// Inicializa la aplicación con manejo de errores global
void main() {
  // Manejo de errores de Flutter
  FlutterError.onError = (FlutterErrorDetails details) {
    AppLogger.error(
      'Flutter Error: ${details.exception}',
      details.exception,
      details.stack,
      'FlutterError',
    );
  };
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
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
        
        home: const GoogleAuthScreen(),
      ),
    );
  }
}