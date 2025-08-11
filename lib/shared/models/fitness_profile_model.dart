/// Modelo de perfil físico del usuario
class FitnessProfileModel {
  final String userId;
  final double weight; // kg
  final double height; // cm
  final int age;
  final String activityLevel; // 'sedentary', 'light', 'moderate', 'active'
  final int screenTimeHours; // horas diarias
  final double currentWaterIntake; // litros
  final double currentSleepHours; // horas
  final int currentDailySteps;
  final List<String> healthConditions;
  final DateTime createdAt;

  const FitnessProfileModel({
    required this.userId,
    required this.weight,
    required this.height,
    required this.age,
    required this.activityLevel,
    required this.screenTimeHours,
    required this.currentWaterIntake,
    required this.currentSleepHours,
    required this.currentDailySteps,
    required this.healthConditions,
    required this.createdAt,
  });

  /// Calcula BMI del usuario
  double get bmi => weight / ((height / 100) * (height / 100));

  /// Categoría de BMI
  String get bmiCategory {
    if (bmi < 18.5) return 'Bajo peso';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Sobrepeso';
    return 'Obesidad';
  }

  factory FitnessProfileModel.fromJson(Map<String, dynamic> json) {
    return FitnessProfileModel(
      userId: json['userId'] ?? '',
      weight: (json['weight'] ?? 70.0).toDouble(),
      height: (json['height'] ?? 170.0).toDouble(),
      age: json['age'] ?? 25,
      activityLevel: json['activityLevel'] ?? 'sedentary',
      screenTimeHours: json['screenTimeHours'] ?? 8,
      currentWaterIntake: (json['currentWaterIntake'] ?? 1.5).toDouble(),
      currentSleepHours: (json['currentSleepHours'] ?? 6.0).toDouble(),
      currentDailySteps: json['currentDailySteps'] ?? 3000,
      healthConditions: List<String>.from(json['healthConditions'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'weight': weight,
      'height': height,
      'age': age,
      'activityLevel': activityLevel,
      'screenTimeHours': screenTimeHours,
      'currentWaterIntake': currentWaterIntake,
      'currentSleepHours': currentSleepHours,
      'currentDailySteps': currentDailySteps,
      'healthConditions': healthConditions,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}