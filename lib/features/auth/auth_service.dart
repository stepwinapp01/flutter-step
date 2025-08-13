import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Retorna un mapa con `success: true` si el login fue exitoso
  static Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return {'success': false}; // Usuario canceló

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      await _saveUserToFirestore(userCredential.user!);
      return {'success': true, 'user': userCredential.user};
    } catch (e) {
      print('Error en AuthService.signInWithGoogle: $e');
      return {'success': false, 'error': e.toString()};
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

  static Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  /// Envía código de verificación por SMS
  static Future<Map<String, dynamic>> sendSMSCode(String phoneNumber) async {
    try {
      String verificationId = '';
      
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verificación (solo en Android)
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Error verificación SMS: ${e.message}');
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
      
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      // Guardar usuario en Firestore si no existe
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid);

      final docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        await userDoc.set({
          'phone': userCredential.user!.phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      
      return {'success': true, 'user': userCredential.user};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  static User? get currentUser => _auth.currentUser;
  static bool get isSignedIn => _auth.currentUser != null;
}