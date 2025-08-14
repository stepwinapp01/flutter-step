class FitnessProfileModel {
  final String userId;
  final double weight;
  final double height;
  final int age;
  final String activityLevel;
  final int screenTimeHours;
  final int currentWaterGlasses;
  final double currentSleepHours;
  final int currentWalkingMinutes;
  final int currentMeditationMinutes;
  final List<String> healthConditions;
  final DateTime createdAt;

  FitnessProfileModel({
    required this.userId,
    required this.weight,
    required this.height,
    required this.age,
    required this.activityLevel,
    required this.screenTimeHours,
    required this.currentWaterGlasses,
    required this.currentSleepHours,
    required this.currentWalkingMinutes,
    required this.currentMeditationMinutes,
    required this.healthConditions,
    required this.createdAt,
  });
}