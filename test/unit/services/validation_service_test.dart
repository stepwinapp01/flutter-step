import 'package:flutter_test/flutter_test.dart';
import 'package:step_win_app/shared/services/validation_service.dart';

/// Tests para ValidationService
void main() {
  group('ValidationService Tests', () {
    test('should validate age correctly', () {
      final birthDate16 = DateTime.now().subtract(const Duration(days: 16 * 365));
      final birthDate15 = DateTime.now().subtract(const Duration(days: 15 * 365));
      final birthDate17 = DateTime.now().subtract(const Duration(days: 17 * 365));

      // Menor de 16 años
      final result15 = ValidationService.validateAge(birthDate15, false);
      expect(result15.isValid, isFalse);
      expect(result15.message, contains('16 años'));

      // 16 años sin autorización parental
      final result16NoConsent = ValidationService.validateAge(birthDate16, false);
      expect(result16NoConsent.isValid, isFalse);
      expect(result16NoConsent.message, contains('parental'));

      // 16 años con autorización parental
      final result16WithConsent = ValidationService.validateAge(birthDate16, true);
      expect(result16WithConsent.isValid, isTrue);

      // 17 años con autorización parental
      final result17 = ValidationService.validateAge(birthDate17, true);
      expect(result17.isValid, isTrue);
    });

    test('should require facial recognition for level 2+', () {
      expect(ValidationService.requiresFacialRecognition(1), isFalse);
      expect(ValidationService.requiresFacialRecognition(2), isTrue);
      expect(ValidationService.requiresFacialRecognition(5), isTrue);
    });

    test('should validate level up requirements', () {
      // Nivel 1 a 2 con plan básico
      final result1to2 = ValidationService.validateLevelUp(1, 'basic', 15);
      expect(result1to2.isValid, isTrue);

      // Nivel 3 a 4 requiere plan pro
      final result3to4Basic = ValidationService.validateLevelUp(3, 'basic', 100);
      expect(result3to4Basic.isValid, isFalse);
      expect(result3to4Basic.message, contains('PRO'));

      // Nivel 3 a 4 con plan pro
      final result3to4Pro = ValidationService.validateLevelUp(3, 'pro', 100);
      expect(result3to4Pro.isValid, isTrue);
    });

    test('should calculate inactivity penalty correctly', () {
      final now = DateTime.now();
      const stakedTokens = 100.0;

      // Sin penalización (7 días o menos)
      final penalty7Days = ValidationService.calculateInactivityPenalty(
        now.subtract(const Duration(days: 7)), 
        stakedTokens
      );
      expect(penalty7Days, equals(0.0));

      // 5% penalización (8-14 días)
      final penalty10Days = ValidationService.calculateInactivityPenalty(
        now.subtract(const Duration(days: 10)), 
        stakedTokens
      );
      expect(penalty10Days, equals(5.0));

      // 15% penalización (15-30 días)
      final penalty20Days = ValidationService.calculateInactivityPenalty(
        now.subtract(const Duration(days: 20)), 
        stakedTokens
      );
      expect(penalty20Days, equals(15.0));

      // 30% penalización máxima (30+ días)
      final penalty40Days = ValidationService.calculateInactivityPenalty(
        now.subtract(const Duration(days: 40)), 
        stakedTokens
      );
      expect(penalty40Days, equals(30.0));
    });
  });
}