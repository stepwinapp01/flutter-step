import 'package:flutter/foundation.dart';

/// Utilidad de logging para la aplicación Step Win
/// 
/// Proporciona logging estructurado con diferentes niveles
/// Solo registra en modo debug para evitar logs en producción
class AppLogger {
  static const String _tag = 'StepWin';
  
  /// Registra mensaje de información
  /// [message] Mensaje a registrar
  /// [tag] Etiqueta opcional para categorizar
  static void info(String message, [String? tag]) {
    if (kDebugMode) {
      print('[$_tag${tag != null ? ':$tag' : ''}] INFO: $message');
    }
  }
  
  /// Registra mensaje de error
  /// [message] Mensaje de error
  /// [error] Objeto de error opcional
  /// [stackTrace] Stack trace opcional
  /// [tag] Etiqueta opcional
  static void error(String message, [Object? error, StackTrace? stackTrace, String? tag]) {
    if (kDebugMode) {
      print('[$_tag${tag != null ? ':$tag' : ''}] ERROR: $message');
      if (error != null) print('Error object: $error');
      if (stackTrace != null) print('Stack trace: $stackTrace');
    }
  }
  
  /// Registra mensaje de debug
  /// [message] Mensaje de debug
  /// [tag] Etiqueta opcional
  static void debug(String message, [String? tag]) {
    if (kDebugMode) {
      print('[$_tag${tag != null ? ':$tag' : ''}] DEBUG: $message');
    }
  }
  
  /// Registra mensaje de advertencia
  /// [message] Mensaje de advertencia
  /// [tag] Etiqueta opcional
  static void warning(String message, [String? tag]) {
    if (kDebugMode) {
      print('[$_tag${tag != null ? ':$tag' : ''}] WARNING: $message');
    }
  }
}