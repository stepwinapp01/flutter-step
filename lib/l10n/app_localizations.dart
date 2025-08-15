import 'package:flutter/material.dart';

/// Clase de localizaciones para la aplicación Step Win
/// 
/// Maneja las traducciones de strings en la aplicación
/// Soporta español e inglés
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// Obtiene la instancia de localizaciones del contexto
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Delegate para el sistema de localización de Flutter
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// Idiomas soportados
  static const List<Locale> supportedLocales = [
    Locale('es', ''), // Español
    Locale('en', ''), // Inglés
  ];

  // Strings de la aplicación
  String get appName => _localizedValues[locale.languageCode]!['appName']!;
  String get welcome => _localizedValues[locale.languageCode]!['welcome']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get forgotPassword => _localizedValues[locale.languageCode]!['forgotPassword']!;
  String get signUp => _localizedValues[locale.languageCode]!['signUp']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get goals => _localizedValues[locale.languageCode]!['goals']!;
  String get rewards => _localizedValues[locale.languageCode]!['rewards']!;
  String get progress => _localizedValues[locale.languageCode]!['progress']!;
  String get community => _localizedValues[locale.languageCode]!['community']!;
  String get coach => _localizedValues[locale.languageCode]!['coach']!;
  String get tokens => _localizedValues[locale.languageCode]!['tokens']!;
  String get level => _localizedValues[locale.languageCode]!['level']!;
  String get steps => _localizedValues[locale.languageCode]!['steps']!;
  String get sleep => _localizedValues[locale.languageCode]!['sleep']!;
  String get water => _localizedValues[locale.languageCode]!['water']!;
  String get meditation => _localizedValues[locale.languageCode]!['meditation']!;
  String get wallet => _localizedValues[locale.languageCode]!['wallet']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get todayProgress => _localizedValues[locale.languageCode]!['todayProgress']!;
  String get quickActions => _localizedValues[locale.languageCode]!['quickActions']!;
  String get logSteps => _localizedValues[locale.languageCode]!['logSteps']!;
  String get logWater => _localizedValues[locale.languageCode]!['logWater']!;
  String get meditate => _localizedValues[locale.languageCode]!['meditate']!;
  String get chatCoach => _localizedValues[locale.languageCode]!['chatCoach']!;
  String get viewAll => _localizedValues[locale.languageCode]!['viewAll']!;
  
  // Mensajes de error
  String get errorEmptyMessage => _localizedValues[locale.languageCode]!['errorEmptyMessage']!;
  String get errorMessageTooLong => _localizedValues[locale.languageCode]!['errorMessageTooLong']!;
  String get errorGeneratingResponse => _localizedValues[locale.languageCode]!['errorGeneratingResponse']!;
  String get errorGeneric => _localizedValues[locale.languageCode]!['errorGeneric']!;

  // Mapa de traducciones
  static const Map<String, Map<String, String>> _localizedValues = {
    'es': {
      'appName': 'Step Win',
      'welcome': 'Bienvenido',
      'login': 'Iniciar Sesión',
      'email': 'Correo Electrónico',
      'password': 'Contraseña',
      'forgotPassword': '¿Olvidaste tu contraseña?',
      'signUp': 'Registrarse',
      'home': 'Inicio',
      'goals': 'Metas',
      'rewards': 'Recompensas',
      'progress': 'Progreso',
      'community': 'Comunidad',
      'coach': 'Coach',
      'tokens': 'Tokens',
      'level': 'Nivel',
      'steps': 'Pasos',
      'sleep': 'Sueño',
      'water': 'Agua',
      'meditation': 'Meditación',
      'wallet': 'Billetera',
      'settings': 'Ajustes',
      'todayProgress': 'Progreso de Hoy',
      'quickActions': 'Acciones Rápidas',
      'logSteps': 'Registrar Pasos',
      'logWater': 'Registrar Agua',
      'meditate': 'Meditar',
      'chatCoach': 'Chat con Coach',
      'viewAll': 'Ver Todo',
      'errorEmptyMessage': 'El mensaje no puede estar vacío',
      'errorMessageTooLong': 'El mensaje es demasiado largo (máximo 500 caracteres)',
      'errorGeneratingResponse': 'Error al generar respuesta. Inténtalo de nuevo.',
      'errorGeneric': 'Ha ocurrido un error. Por favor, inténtalo de nuevo.',
    },
    'en': {
      'appName': 'Step Win',
      'welcome': 'Welcome',
      'login': 'Login',
      'email': 'Email',
      'password': 'Password',
      'forgotPassword': 'Forgot your password?',
      'signUp': 'Sign Up',
      'home': 'Home',
      'goals': 'Goals',
      'rewards': 'Rewards',
      'progress': 'Progress',
      'community': 'Community',
      'coach': 'Coach',
      'tokens': 'Tokens',
      'level': 'Level',
      'steps': 'Steps',
      'sleep': 'Sleep',
      'water': 'Water',
      'meditation': 'Meditation',
      'wallet': 'Wallet',
      'settings': 'Settings',
      'todayProgress': 'Today\'s Progress',
      'quickActions': 'Quick Actions',
      'logSteps': 'Log Steps',
      'logWater': 'Log Water',
      'meditate': 'Meditate',
      'chatCoach': 'Chat with Coach',
      'viewAll': 'View All',
      'errorEmptyMessage': 'Message cannot be empty',
      'errorMessageTooLong': 'Message is too long (maximum 500 characters)',
      'errorGeneratingResponse': 'Error generating response. Please try again.',
      'errorGeneric': 'An error occurred. Please try again.',
    },
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['es', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}