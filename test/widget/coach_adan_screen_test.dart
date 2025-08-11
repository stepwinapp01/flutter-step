import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:step_win_app/features/coach/presentation/coach_adan_screen.dart';
import 'package:step_win_app/features/coach/providers/chat_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Coach Adan screen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ChatProvider(),
        child: const MaterialApp(home: CoachAdanScreen()),
      ),
    );
    
    expect(find.text('Coach Adán'), findsAtLeastNWidgets(1));
    expect(find.text('Chat'), findsOneWidget);
    expect(find.text('Mi Plan'), findsOneWidget);
    expect(find.text('Consejos'), findsOneWidget);
  });

  testWidgets('Chat tab shows welcome message', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ChatProvider(),
        child: const MaterialApp(home: CoachAdanScreen()),
      ),
    );
    
    expect(find.textContaining('¡Hola! Soy Coach Adán'), findsOneWidget);
  });
}