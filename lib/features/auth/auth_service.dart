import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Servicio para gestionar todos los métodos de autenticación de Firebase.
class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Inicia sesión con Google y maneja errores de forma controlada
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        debugPrint("Inicio de sesión con Google cancelado por el usuario.");
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        await _saveUserToFirestore(userCredential.user!);
        return userCredential;
      } else {
        throw Exception('Error en la autenticación: usuario nulo');
      }

    } on PlatformException catch (e, s) {
      debugPrint("Error de plataforma en Google Sign-In: ${e.code}\nStackTrace: $s");
      
      String userMessage = "Ocurrió un error inesperado. Inténtalo de nuevo.";
      if (e.code == 'network_error') {
        userMessage = "No se pudo conectar. Revisa tu conexión a internet.";
      } else if (e.code == 'sign_in_failed' || e.code == '10') {
        userMessage = "Hubo un problema al iniciar sesión. Por favor, contacta a soporte.";
        if (kDebugMode) {
          userMessage += " (Dev: Revisa la configuración de SHA-1 en Firebase).";
        }
      }
      throw Exception(userMessage);

    } catch (e, s) {
      debugPrint("Error inesperado en signInWithGoogle: $e\nStackTrace: $s");
      throw Exception("Ocurrió un error inesperado. Inténtalo de nuevo más tarde.");
    }
  }

  /// Inicia el proceso de verificación del número de teléfono.
  static Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 60),
    );
  }

  /// Inicia sesión con el código SMS y el ID de verificación.
  static Future<UserCredential?> signInWithSmsCode(String verificationId, String smsCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        await _saveUserToFirestore(userCredential.user!);
      }
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        throw Exception('El código de verificación no es válido.');
      } else if (e.code == 'session-expired') {
        throw Exception('El código ha expirado. Por favor, solicita uno nuevo.');
      }
      debugPrint("Error en signInWithSmsCode: ${e.code} - ${e.message}");
      throw Exception('Ocurrió un error al verificar el código.');
    } catch (e) {
      debugPrint("Error inesperado en signInWithSmsCode: $e");
      throw Exception('Ocurrió un error inesperado. Inténtalo de nuevo.');
    }
  }

  /// Envía código SMS al número de teléfono
  static Future<Map<String, dynamic>> sendSMSCode(String phoneNumber) async {
    try {
      String? verificationId;
      
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verificación (solo en Android)
          final userCredential = await _auth.signInWithCredential(credential);
          await _saveUserToFirestore(userCredential.user!);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Error verificación SMS: $e');
        },
        codeSent: (String verId, int? resendToken) {
          verificationId = verId;
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
        timeout: const Duration(seconds: 60),
      );
      
      return {'success': true, 'verificationId': verificationId};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Verifica el código SMS y completa el login
  static Future<Map<String, dynamic>> verifySMSCode(String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      
      final userCredential = await _auth.signInWithCredential(credential);
      await _saveUserToFirestore(userCredential.user!);
      
      return {'success': true, 'user': userCredential.user};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Guarda usuario en Firestore
  static Future<void> _saveUserToFirestore(User user) async {
    try {
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      final docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        await userDoc.set({
          'name': user.displayName ?? 'Usuario',
          'email': user.email,
          'phone': user.phoneNumber,
          'photoURL': user.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error guardando usuario: $e');
    }
  }

  /// Cierra la sesión del usuario actual.
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  /// Stream para escuchar los cambios en el estado de autenticación.
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  static User? get currentUser => _auth.currentUser;
  static bool get isSignedIn => _auth.currentUser != null;
}