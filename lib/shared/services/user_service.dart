import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  
  static Future<void> saveUserProfile(UserModel user) async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      await _firestore.collection('users').doc(currentUser.uid).set(user.toJson());
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
    final user = await getUserProfile();
    return user?.hasCompletedOnboarding ?? false;
  }
  
  static Future<void> markOnboardingComplete() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      try {
        await _firestore.collection('users').doc(currentUser.uid).update({
          'hasCompletedOnboarding': true,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        print('Onboarding marked as complete for user: ${currentUser.uid}');
      } catch (e) {
        print('Error marking onboarding complete: $e');
        // Intentar crear el documento si no existe
        try {
          await _firestore.collection('users').doc(currentUser.uid).set({
            'uid': currentUser.uid,
            'email': currentUser.email ?? '',
            'name': currentUser.displayName ?? '',
            'hasCompletedOnboarding': true,
            'level': 1,
            'plan': 'basic',
            'tokenBalance': 0,
            'kycVerified': false,
            'facialRecognitionDone': true,
            'language': 'es',
            'createdAt': FieldValue.serverTimestamp(),
            'lastActive': FieldValue.serverTimestamp(),
            'connectedDevices': {},
            'medicalConditions': [],
          }, SetOptions(merge: true));
          print('User document created with onboarding complete');
        } catch (createError) {
          print('Error creating user document: $createError');
          rethrow;
        }
      }
    } else {
      throw Exception('No authenticated user found');
    }
  }
}