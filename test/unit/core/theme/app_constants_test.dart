import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:step_win_app/core/constants/app_constants.dart';

void main() {
  group('AppConstants', () {
    test('should have valid color values', () {
      expect(AppConstants.primaryPurple, isA<Color>());
      expect(AppConstants.secondaryPurple, isA<Color>());
      expect(AppConstants.primaryPurple, const Color(0xFF6B46C1));
      expect(AppConstants.secondaryPurple, const Color(0xFF8B5CF6));
    });

    test('should have valid padding values', () {
      expect(AppConstants.defaultPadding, 16.0);
      expect(AppConstants.smallPadding, 8.0);
      expect(AppConstants.largePadding, 24.0);
    });
  });
}