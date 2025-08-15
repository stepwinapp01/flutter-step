import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Métodos estáticos
  static Future<void> saveUserProfile(UserModel user) async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      await _firestore.collection('users').doc(currentUser.uid).set(user.toJson(), SetOptions(merge: true));
    }
  }
  
  static Future<UserModel?> getUserProfile() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final doc = await _firestore.collection('users').doc(currentUser.uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
    }
    return null;
  }
  
  static Future<bool> hasCompletedOnboarding() async {
    try {
      final user = await getUserProfile();
      return user?.hasCompletedOnboarding ?? false;
    } catch (e) {
      print('Error checking onboarding status: $e');
      return false;
    }
  }
  
  // Métodos de instancia para compatibilidad
  Future<void> completeOnboarding() async {
    await UserService.markOnboardingComplete();
  }
  
  static Future<void> markOnboardingComplete() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('No authenticated user found');
    }
    
    try {
      // Intentar obtener el usuario existente
      final existingUser = await getUserProfile();
      
      if (existingUser != null) {
        // Actualizar usuario existente
        final updatedUser = existingUser.copyWith(
          hasCompletedOnboarding: true,
          lastActive: DateTime.now(),
        );
        await saveUserProfile(updatedUser);
      } else {
        // Crear nuevo usuario
        final newUser = UserModel(
          uid: currentUser.uid,
          email: currentUser.email ?? '',
          name: currentUser.displayName ?? 'Usuario',
          hasCompletedOnboarding: true,
          level: 1,
          plan: 'basic',
          tokenBalance: 0,
          kycVerified: false,
          facialRecognitionDone: true,
          language: 'es',
          createdAt: DateTime.now(),
          lastActive: DateTime.now(),
          connectedDevices: {},
          medicalConditions: [],
        );
        await saveUserProfile(newUser);
      }
      print('Onboarding completed successfully for user: ${currentUser.uid}');
    } catch (e) {
      print('Error completing onboarding: $e');
      rethrow;
    }
  }
}