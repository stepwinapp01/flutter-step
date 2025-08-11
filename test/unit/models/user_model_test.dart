import 'package:flutter_test/flutter_test.dart';
import 'package:step_win_app/shared/models/user_model.dart';

/// Tests unitarios para UserModel
/// 
/// Verifica la correcta serialización, deserialización y
/// funcionalidad del modelo de usuario
void main() {
  group('UserModel Tests', () {
    late UserModel testUser;
    late Map<String, dynamic> testJson;

    setUp(() {
      testUser = UserModel(
        uid: 'test-uid-123',
        email: 'test@example.com',
        name: 'Test User',
        photoUrl: 'https://example.com/photo.jpg',
        level: 5,
        plan: 'pro',
        tokenBalance: 150.5,
        kycVerified: true,
        facialRecognitionDone: true,
        language: 'es',
        createdAt: DateTime.now(),
        lastActive: DateTime.now(),
        teamCode: 'TEAM123',
        connectedDevices: const {'smartwatch': true, 'fitbit': false},
      );

      testJson = {
        'uid': 'test-uid-123',
        'email': 'test@example.com',
        'name': 'Test User',
        'photoUrl': 'https://example.com/photo.jpg',
        'level': 5,
        'plan': 'pro',
        'tokenBalance': 150.5,
        'kycVerified': true,
        'facialRecognitionDone': true,
        'language': 'es',
        'createdAt': DateTime.now().toIso8601String(),
        'lastActive': DateTime.now().toIso8601String(),
        'teamCode': 'TEAM123',
        'connectedDevices': {'smartwatch': true, 'fitbit': false},
      };
    });

    test('should create UserModel from JSON correctly', () {
      final user = UserModel.fromJson(testJson);

      expect(user.uid, equals('test-uid-123'));
      expect(user.email, equals('test@example.com'));
      expect(user.name, equals('Test User'));
      expect(user.level, equals(5));
      expect(user.plan, equals('pro'));
      expect(user.tokenBalance, equals(150.5));
      expect(user.kycVerified, isTrue);
      expect(user.facialRecognitionDone, isTrue);
      expect(user.language, equals('es'));
      expect(user.teamCode, equals('TEAM123'));
      expect(user.connectedDevices['smartwatch'], isTrue);
      expect(user.connectedDevices['fitbit'], isFalse);
    });

    test('should handle null values in JSON with defaults', () {
      final minimalJson = {
        'uid': 'test-uid',
        'email': 'test@example.com',
        'name': 'Test User',
      };

      final user = UserModel.fromJson(minimalJson);

      expect(user.level, equals(1)); // Default
      expect(user.plan, equals('basic')); // Default
      expect(user.tokenBalance, equals(0.0)); // Default
      expect(user.kycVerified, isFalse); // Default
      expect(user.facialRecognitionDone, isFalse); // Default
      expect(user.language, equals('es')); // Default
      expect(user.connectedDevices, isEmpty); // Default
    });

    test('should convert UserModel to JSON correctly', () {
      final now = DateTime.now();
      final user = testUser.copyWith(
        createdAt: now,
        lastActive: now,
      );

      final json = user.toJson();

      expect(json['uid'], equals('test-uid-123'));
      expect(json['email'], equals('test@example.com'));
      expect(json['name'], equals('Test User'));
      expect(json['level'], equals(5));
      expect(json['plan'], equals('pro'));
      expect(json['tokenBalance'], equals(150.5));
      expect(json['kycVerified'], isTrue);
      expect(json['facialRecognitionDone'], isTrue);
      expect(json['language'], equals('es'));
      expect(json['teamCode'], equals('TEAM123'));
      expect(json['connectedDevices'], isA<Map<String, bool>>());
    });

    test('should create copy with updated fields', () {
      final now = DateTime.now();
      final originalUser = testUser.copyWith(
        createdAt: now,
        lastActive: now,
      );

      final updatedUser = originalUser.copyWith(
        level: 6,
        tokenBalance: 200.0,
        plan: 'elite',
      );

      expect(updatedUser.level, equals(6));
      expect(updatedUser.tokenBalance, equals(200.0));
      expect(updatedUser.plan, equals('elite'));
      
      // Campos no modificados deben mantenerse
      expect(updatedUser.uid, equals(originalUser.uid));
      expect(updatedUser.email, equals(originalUser.email));
      expect(updatedUser.name, equals(originalUser.name));
    });

    test('should maintain immutability', () {
      final now = DateTime.now();
      final user1 = testUser.copyWith(
        createdAt: now,
        lastActive: now,
      );
      
      final user2 = user1.copyWith(level: 10);

      expect(user1.level, equals(5)); // Original no debe cambiar
      expect(user2.level, equals(10)); // Nueva instancia con cambio
    });
  });
}