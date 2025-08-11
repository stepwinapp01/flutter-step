/// Modelo para metas diarias de salud
class HealthGoalModel {
  final String id;
  final String userId;
  final DateTime date;
  final int steps;
  final int targetSteps;
  final double sleepHours;
  final double targetSleepHours;
  final double waterLiters;
  final double targetWaterLiters;
  final int meditationMinutes;
  final int targetMeditationMinutes;
  final bool coachSessionCompleted;
  final double tokensEarned;
  final bool isCompleted;

  const HealthGoalModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.steps,
    required this.targetSteps,
    required this.sleepHours,
    required this.targetSleepHours,
    required this.waterLiters,
    required this.targetWaterLiters,
    required this.meditationMinutes,
    required this.targetMeditationMinutes,
    required this.coachSessionCompleted,
    required this.tokensEarned,
    required this.isCompleted,
  });

  factory HealthGoalModel.fromJson(Map<String, dynamic> json) {
    return HealthGoalModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      steps: json['steps'] ?? 0,
      targetSteps: json['targetSteps'] ?? 10000,
      sleepHours: (json['sleepHours'] ?? 0).toDouble(),
      targetSleepHours: (json['targetSleepHours'] ?? 7).toDouble(),
      waterLiters: (json['waterLiters'] ?? 0).toDouble(),
      targetWaterLiters: (json['targetWaterLiters'] ?? 2).toDouble(),
      meditationMinutes: json['meditationMinutes'] ?? 0,
      targetMeditationMinutes: json['targetMeditationMinutes'] ?? 10,
      coachSessionCompleted: json['coachSessionCompleted'] ?? false,
      tokensEarned: (json['tokensEarned'] ?? 0).toDouble(),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'steps': steps,
      'targetSteps': targetSteps,
      'sleepHours': sleepHours,
      'targetSleepHours': targetSleepHours,
      'waterLiters': waterLiters,
      'targetWaterLiters': targetWaterLiters,
      'meditationMinutes': meditationMinutes,
      'targetMeditationMinutes': targetMeditationMinutes,
      'coachSessionCompleted': coachSessionCompleted,
      'tokensEarned': tokensEarned,
      'isCompleted': isCompleted,
    };
  }

  /// Calcula el progreso general del día (0.0 a 1.0)
  double get overallProgress {
    double stepsProgress = (steps / targetSteps).clamp(0.0, 1.0);
    double sleepProgress = (sleepHours / targetSleepHours).clamp(0.0, 1.0);
    double waterProgress = (waterLiters / targetWaterLiters).clamp(0.0, 1.0);
    double meditationProgress = (meditationMinutes / targetMeditationMinutes).clamp(0.0, 1.0);
    double coachProgress = coachSessionCompleted ? 1.0 : 0.0;
    
    return (stepsProgress + sleepProgress + waterProgress + meditationProgress + coachProgress) / 5;
  }

  /// Calcula tokens ganados basado en progreso
  double calculateTokens() {
    double baseTokens = (steps / 1000) * 10; // 10 tokens por cada 1000 pasos
    if (sleepHours >= targetSleepHours) baseTokens += 50;
    if (waterLiters >= targetWaterLiters) baseTokens += 30;
    if (meditationMinutes >= targetMeditationMinutes) baseTokens += 40;
    if (coachSessionCompleted) baseTokens += 60;
    return baseTokens;
  }
}