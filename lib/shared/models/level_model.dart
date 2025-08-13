import 'package:flutter/material.dart';

class LevelModel {
  final int level;
  final String name;
  final String description;
  final int subscriptionPrice;
  final int requiredMembers;
  final int monthlyEarnings;
  final int completionBonus;
  final int equipmentBonus;
  final Color primaryColor;
  final Color secondaryColor;

  const LevelModel({
    required this.level,
    required this.name,
    required this.description,
    required this.subscriptionPrice,
    required this.requiredMembers,
    required this.monthlyEarnings,
    required this.completionBonus,
    required this.equipmentBonus,
    required this.primaryColor,
    required this.secondaryColor,
  });
}