import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:step_win_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('should load app and navigate through tabs', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify app loads
      expect(find.text('Coach Adán'), findsAtLeastNWidgets(1));
      
      // Test tab navigation
      await tester.tap(find.text('Mi Plan'));
      await tester.pumpAndSettle();
      expect(find.text('Mi Plan Personalizado'), findsOneWidget);

      await tester.tap(find.text('Consejos'));
      await tester.pumpAndSettle();
      expect(find.text('Consejos de Salud'), findsOneWidget);

      await tester.tap(find.text('Chat'));
      await tester.pumpAndSettle();
      expect(find.textContaining('¡Hola! Soy Coach Adán'), findsOneWidget);
    });

    testWidgets('should send and receive chat messages', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Find and tap message input
      final messageField = find.byType(TextField);
      await tester.tap(messageField);
      await tester.enterText(messageField, 'Test message');
      
      // Send message
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Verify user message appears
      expect(find.text('Test message'), findsOneWidget);
      
      // Wait for coach response
      await tester.pumpAndSettle(const Duration(seconds: 2));
      
      // Verify coach responded
      expect(find.textContaining('Excelente'), findsAny);
    });
  });
}