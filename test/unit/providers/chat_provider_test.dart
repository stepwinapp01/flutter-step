import 'package:flutter_test/flutter_test.dart';
import 'package:step_win_app/features/coach/providers/chat_provider.dart';
import 'package:step_win_app/features/coach/models/chat_message.dart';

void main() {
  group('ChatProvider', () {
    late ChatProvider chatProvider;

    setUp(() {
      chatProvider = ChatProvider();
    });

    test('should initialize with welcome message', () {
      expect(chatProvider.messages.length, 1);
      expect(chatProvider.messages.first.isCoach, true);
      expect(chatProvider.messages.first.message, contains('¡Hola! Soy Coach Adán'));
    });

    test('should add message correctly', () {
      final testMessage = ChatMessage.user(message: 'Test message');
      
      chatProvider.addMessage(testMessage);
      
      expect(chatProvider.messages.length, 2);
      expect(chatProvider.messages.last.message, 'Test message');
      expect(chatProvider.messages.last.isCoach, false);
    });

    test('should not send empty message', () {
      final initialCount = chatProvider.messages.length;
      
      chatProvider.sendUserMessage('');
      chatProvider.sendUserMessage('   ');
      
      expect(chatProvider.messages.length, initialCount);
    });

    test('should send user message and generate coach response', () async {
      final initialCount = chatProvider.messages.length;
      
      chatProvider.sendUserMessage('How can I improve?');
      
      expect(chatProvider.messages.length, initialCount + 1);
      expect(chatProvider.messages.last.message, 'How can I improve?');
      expect(chatProvider.messages.last.isCoach, false);
      
      // Wait for coach response
      await Future.delayed(const Duration(seconds: 2));
      
      expect(chatProvider.messages.length, initialCount + 2);
      expect(chatProvider.messages.last.isCoach, true);
      expect(chatProvider.messages.last.message, isNotEmpty);
    });
  });
}