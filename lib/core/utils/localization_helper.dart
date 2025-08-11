import 'package:flutter/material.dart';

/// Helper class para facilitar el acceso a las localizaciones
class LocalizationHelper {
  /// Verifica si el idioma actual es español
  /// 
  /// [context] El BuildContext actual
  /// Returns true si el idioma es español
  static bool isSpanish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'es';
  }
  
  /// Verifica si el idioma actual es inglés
  /// 
  /// [context] El BuildContext actual
  /// Returns true si el idioma es inglés
  static bool isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en';
  }
  
  /// Obtiene el código de idioma actual
  /// 
  /// [context] El BuildContext actual
  /// Returns el código de idioma (ej: 'es', 'en')
  static String getLanguageCode(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }
}