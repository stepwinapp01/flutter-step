import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:step_win_app/core/theme/app_constants.dart';

void main() {
  group('AppConstants', () {
    test('should have valid color values', () {
      expect(AppConstants.primaryPurple, isA<Color>());
      expect(AppConstants.secondaryPurple, isA<Color>());
      expect(AppConstants.white, Colors.white);
      expect(AppConstants.black, Colors.black);
      expect(AppConstants.grey, Colors.grey);
      expect(AppConstants.lightGrey, isA<Color>());
      expect(AppConstants.success, isA<Color>());
      expect(AppConstants.warning, isA<Color>());
    });

    test('should have valid levels map', () {
      expect(AppConstants.levels, isNotEmpty);
      expect(AppConstants.levels.length, greaterThan(0));
      
      AppConstants.levels.forEach((level, data) {
        expect(level, isA<int>());
        expect(level, greaterThan(0));
        expect(data['name'], isA<String>());
        expect(data['name'], isNotEmpty);
        expect(data['color'], isA<Color>());
      });
    });

    test('should have specific level names', () {
      expect(AppConstants.levels[1]?['name'], 'Principiante');
      expect(AppConstants.levels[2]?['name'], 'Novato');
      expect(AppConstants.levels[3]?['name'], 'Intermedio');
      expect(AppConstants.levels[4]?['name'], 'Avanzado');
      expect(AppConstants.levels[5]?['name'], 'Experto');
      expect(AppConstants.levels[10]?['name'], 'Maestro');
    });
  });
}