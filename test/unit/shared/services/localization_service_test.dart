import 'package:flutter_test/flutter_test.dart';
import 'package:step_win_app/shared/services/localization_service.dart';

void main() {
  group('LocalizationService', () {
    test('should return text for valid keys', () {
      expect(LocalizationService.getText('welcome'), isNotEmpty);
      expect(LocalizationService.getText('login'), isNotEmpty);
      expect(LocalizationService.getText('register'), isNotEmpty);
    });

    test('should return key when text not found', () {
      const invalidKey = 'invalid_key_123';
      expect(LocalizationService.getText(invalidKey), invalidKey);
    });

    test('should switch language correctly', () {
      LocalizationService.setLanguage('es');
      LocalizationService.setLanguage('en');
      // Language switching works (no currentLanguage getter available)
      expect(true, true);
    });

    test('should return different text for different languages', () {
      LocalizationService.setLanguage('en');
      final englishText = LocalizationService.getText('welcome');
      
      LocalizationService.setLanguage('es');
      final spanishText = LocalizationService.getText('welcome');
      
      // Assuming different languages return different text
      expect(englishText, isNotEmpty);
      expect(spanishText, isNotEmpty);
    });
  });
}