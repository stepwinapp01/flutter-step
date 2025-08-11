/// Excepciones personalizadas para la aplicación Step Win
/// 
/// Define tipos específicos de errores para manejo consistente
/// en toda la aplicación

/// Excepción base para errores de la aplicación
abstract class AppException implements Exception {
  const AppException(this.message);
  
  /// Mensaje de error (puede ser clave de localización)
  final String message;
  
  @override
  String toString() => 'AppException: $message';
}

/// Excepción para errores de validación de entrada
class ValidationException extends AppException {
  const ValidationException(super.message, {this.code});
  
  final String? code;
  
  @override
  String toString() => 'ValidationException: $message';
}

/// Excepción para errores del chat
class ChatException extends AppException {
  const ChatException(super.message);
  
  @override
  String toString() => 'ChatException: $message';
}

/// Excepción para errores de red
class NetworkException extends AppException {
  const NetworkException(super.message);
  
  @override
  String toString() => 'NetworkException: $message';
}

/// Excepción para errores de autenticación
class AuthException extends AppException {
  const AuthException(super.message);
  
  @override
  String toString() => 'AuthException: $message';
}