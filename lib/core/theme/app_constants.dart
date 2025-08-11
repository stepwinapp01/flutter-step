import 'package:flutter/material.dart';

class AppConstants {
  static const Color primaryPurple = Color(0xFF6B46C1);
  static const Color secondaryPurple = Color(0xFF9333EA);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  
  static const Map<int, Map<String, dynamic>> levels = {
    1: {'name': 'Principiante', 'color': Color(0xFF9CA3AF)},
    2: {'name': 'Novato', 'color': Color(0xFF6B7280)},
    3: {'name': 'Intermedio', 'color': Color(0xFF3B82F6)},
    4: {'name': 'Avanzado', 'color': Color(0xFF8B5CF6)},
    5: {'name': 'Experto', 'color': Color(0xFFF59E0B)},
    10: {'name': 'Maestro', 'color': Color(0xFFEF4444)},
  };
}