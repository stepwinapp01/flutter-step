/// Plan de acondicionamiento físico personalizado
class FitnessPlanModel {
  final String id;
  final String userId;
  final String planName;
  final int targetSteps;
  final double targetWaterLiters;
  final double targetSleepHours;
  final int maxScreenTimeHours;
  final List<String> recommendations;
  final List<WeeklyGoal> weeklyProgression;
  final DateTime createdAt;
  final DateTime validUntil;

  const FitnessPlanModel({
    required this.id,
    required this.userId,
    required this.planName,
    required this.targetSteps,
    required this.targetWaterLiters,
    required this.targetSleepHours,
    required this.maxScreenTimeHours,
    required this.recommendations,
    required this.weeklyProgression,
    required this.createdAt,
    required this.validUntil,
  });

  factory FitnessPlanModel.fromJson(Map<String, dynamic> json) {
    return FitnessPlanModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      planName: json['planName'] ?? '',
      targetSteps: json['targetSteps'] ?? 8000,
      targetWaterLiters: (json['targetWaterLiters'] ?? 2.0).toDouble(),
      targetSleepHours: (json['targetSleepHours'] ?? 7.0).toDouble(),
      maxScreenTimeHours: json['maxScreenTimeHours'] ?? 6,
      recommendations: List<String>.from(json['recommendations'] ?? []),
      weeklyProgression: (json['weeklyProgression'] as List? ?? [])
          .map((w) => WeeklyGoal.fromJson(w))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      validUntil: DateTime.parse(json['validUntil'] ?? DateTime.now().add(const Duration(days: 30)).toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'planName': planName,
      'targetSteps': targetSteps,
      'targetWaterLiters': targetWaterLiters,
      'targetSleepHours': targetSleepHours,
      'maxScreenTimeHours': maxScreenTimeHours,
      'recommendations': recommendations,
      'weeklyProgression': weeklyProgression.map((w) => w.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'validUntil': validUntil.toIso8601String(),
    };
  }
}

/// Meta semanal del plan
class WeeklyGoal {
  final int week;
  final int steps;
  final double water;
  final double sleep;
  final int screenTime;
  final String focus;

  const WeeklyGoal({
    required this.week,
    required this.steps,
    required this.water,
    required this.sleep,
    required this.screenTime,
    required this.focus,
  });

  factory WeeklyGoal.fromJson(Map<String, dynamic> json) {
    return WeeklyGoal(
      week: json['week'] ?? 1,
      steps: json['steps'] ?? 5000,
      water: (json['water'] ?? 2.0).toDouble(),
      sleep: (json['sleep'] ?? 7.0).toDouble(),
      screenTime: json['screenTime'] ?? 8,
      focus: json['focus'] ?? 'Adaptación',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'steps': steps,
      'water': water,
      'sleep': sleep,
      'screenTime': screenTime,
      'focus': focus,
    };
  }
}