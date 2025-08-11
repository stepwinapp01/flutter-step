import 'package:flutter/material.dart';

/// Servicio de autenticación simulado para Google Sign-In
class AuthService {
  static bool _isSignedIn = false;
  static String? _userEmail;
  static String? _userName;

  /// Simula el inicio de sesión con Google
  static Future<Map<String, dynamic>?> signInWithGoogle() async {
    // Simular delay de autenticación
    await Future.delayed(const Duration(seconds: 2));
    
    // Simular éxito (en producción aquí iría la lógica real de Google Sign-In)
    _isSignedIn = true;
    _userEmail = 'usuario@gmail.com';
    _userName = 'Usuario Demo';
    
    return {
      'success': true,
      'email': _userEmail,
      'name': _userName,
    };
  }

  /// Simula el cierre de sesión
  static Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isSignedIn = false;
    _userEmail = null;
    _userName = null;
  }

  /// Verifica si el usuario está autenticado
  static bool get isSignedIn => _isSignedIn;
  
  /// Obtiene el email del usuario
  static String? get userEmail => _userEmail;
  
  /// Obtiene el nombre del usuario
  static String? get userName => _userName;
}