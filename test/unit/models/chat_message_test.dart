import 'package:flutter_test/flutter_test.dart';
import 'package:step_win_app/features/coach/models/chat_message.dart';

void main() {
  group('ChatMessage', () {
    test('should create user message correctly', () {
      final message = ChatMessage.user(message: 'Test message');
      
      expect(message.message, 'Test message');
      expect(message.isCoach, false);
      expect(message.id, isNotEmpty);
      expect(message.timestamp, isA<DateTime>());
    });

    test('should create coach message correctly', () {
      final message = ChatMessage.coach(message: 'Coach response');
      
      expect(message.message, 'Coach response');
      expect(message.isCoach, true);
      expect(message.id, isNotEmpty);
      expect(message.timestamp, isA<DateTime>());
    });
  });
}