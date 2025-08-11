import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:step_win_app/core/utils/localization_helper.dart';

void main() {
  group('LocalizationHelper', () {
    testWidgets('should detect Spanish locale correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          locale: Locale('es'),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [Locale('en'), Locale('es')],
          home: TestWidget(),
        ),
      );

      final context = tester.element(find.byType(TestWidget));
      
      expect(LocalizationHelper.isSpanish(context), true);
      expect(LocalizationHelper.isEnglish(context), false);
      expect(LocalizationHelper.getLanguageCode(context), 'es');
    });

    testWidgets('should detect English locale correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [Locale('en'), Locale('es')],
          home: TestWidget(),
        ),
      );

      final context = tester.element(find.byType(TestWidget));
      
      expect(LocalizationHelper.isEnglish(context), true);
      expect(LocalizationHelper.isSpanish(context), false);
      expect(LocalizationHelper.getLanguageCode(context), 'en');
    });
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('Test'));
  }
}