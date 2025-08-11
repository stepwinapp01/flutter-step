import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_win_app/features/coach/providers/chat_provider.dart';

/// Helper function to create a widget with providers for testing
Widget createTestWidget({
  required Widget child,
  ChatProvider? chatProvider,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<ChatProvider>(
        create: (_) => chatProvider ?? ChatProvider(),
      ),
    ],
    child: MaterialApp(
      home: child,
    ),
  );
}

/// Helper function to create a mock ChatProvider with test data
ChatProvider createMockChatProvider() {
  final provider = ChatProvider();
  return provider;
}

/// Common test constants
class TestConstants {
  static const String testUserMessage = 'Test user message';
  static const String testCoachMessage = 'Test coach response';
  static const Duration testTimeout = Duration(seconds: 5);
}