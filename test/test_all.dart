import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'unit/models/chat_message_test.dart' as chat_message_test;
import 'unit/providers/chat_provider_test.dart' as chat_provider_test;
import 'unit/services/mock_data_service_test.dart' as mock_data_service_test;
import 'unit/core/theme/app_constants_test.dart' as app_constants_test;
import 'unit/shared/services/localization_service_test.dart' as localization_service_test;
import 'widget/coach_adan_screen_test.dart' as coach_screen_test;
import 'widget/chat_bubble_test.dart' as chat_bubble_test;

void main() {
  group('All Tests', () {
    group('Unit Tests', () {
      chat_message_test.main();
      chat_provider_test.main();
      mock_data_service_test.main();
      app_constants_test.main();
      localization_service_test.main();
    });

    group('Widget Tests', () {
      coach_screen_test.main();
      chat_bubble_test.main();
    });
  });
}