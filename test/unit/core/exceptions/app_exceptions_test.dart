import 'package:flutter_test/flutter_test.dart';
import 'package:step_win_app/core/exceptions/app_exceptions.dart';

void main() {
  group('AppExceptions', () {
    test('ValidationException should extend AppException', () {
      const exception = ValidationException('Test validation error');
      
      expect(exception, isA<AppException>());
      expect(exception.message, 'Test validation error');
      expect(exception.code, isNull);
    });

    test('ValidationException should support error code', () {
      const exception = ValidationException('Test error', code: 'VAL001');
      
      expect(exception.message, 'Test error');
      expect(exception.code, 'VAL001');
    });

    test('NetworkException should extend AppException', () {
      const exception = NetworkException('Network error');
      
      expect(exception, isA<AppException>());
      expect(exception.message, 'Network error');
    });

    test('ChatException should extend AppException', () {
      const exception = ChatException('Chat error');
      
      expect(exception, isA<AppException>());
      expect(exception.message, 'Chat error');
    });

    test('AppException toString should return formatted message', () {
      const exception = ValidationException('Test message');
      
      expect(exception.toString(), 'AppException: Test message');
    });
  });
}