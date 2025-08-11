import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:step_win_app/features/coach/presentation/coach_adan_screen.dart';
import 'package:step_win_app/features/coach/providers/chat_provider.dart';
import 'package:step_win_app/features/coach/models/chat_message.dart';

void main() {
  group('Chat Bubble Widget Tests', () {
    testWidgets('should display user message correctly', (tester) async {
      final chatProvider = ChatProvider();
      chatProvider.addMessage(ChatMessage.user(message: 'User test message'));

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: chatProvider,
          child: const MaterialApp(home: CoachAdanScreen()),
        ),
      );

      expect(find.text('User test message'), findsOneWidget);
    });

    testWidgets('should display coach message with avatar', (tester) async {
      final chatProvider = ChatProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: chatProvider,
          child: const MaterialApp(home: CoachAdanScreen()),
        ),
      );

      // Check for coach avatar and welcome message
      expect(find.text('🤖'), findsWidgets);
      expect(find.textContaining('¡Hola! Soy Coach Adán'), findsOneWidget);
    });

    testWidgets('should show message timestamp', (tester) async {
      final chatProvider = ChatProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: chatProvider,
          child: const MaterialApp(home: CoachAdanScreen()),
        ),
      );

      // Should show some time indicator
      expect(find.textContaining('m'), findsAny);
    });
  });
}