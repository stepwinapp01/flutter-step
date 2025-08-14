import '../models/fitness_profile_model.dart';

class FitnessPlan {
  final String planId;
  final String userId;
  final Map<String, dynamic> goals;
  final List<String> recommendations;
  final DateTime createdAt;

  FitnessPlan({
    required this.planId,
    required this.userId,
    required this.goals,
    required this.recommendations,
    required this.createdAt,
  });
}

class FitnessPlanGenerator {
  static FitnessPlan generatePersonalizedPlan(FitnessProfileModel profile) {
    return FitnessPlan(
      planId: 'plan_${DateTime.now().millisecondsSinceEpoch}',
      userId: profile.userId,
      goals: {
        'steps': _calculateStepsGoal(profile),
        'water': _calculateWaterGoal(profile),
        'sleep': _calculateSleepGoal(profile),
        'exercise': _calculateExerciseGoal(profile),
      },
      recommendations: _generateRecommendations(profile),
      createdAt: DateTime.now(),
    );
  }

  static int _calculateStepsGoal(FitnessProfileModel profile) {
    switch (profile.activityLevel) {
      case 'sedentary':
        return 6000;
      case 'light':
        return 8000;
      case 'moderate':
        return 10000;
      case 'active':
        return 12000;
      default:
        return 8000;
    }
  }

  static int _calculateWaterGoal(FitnessProfileModel profile) {
    return 8; // vasos por día
  }

  static double _calculateSleepGoal(FitnessProfileModel profile) {
    return 8.0; // horas por día
  }

  static int _calculateExerciseGoal(FitnessProfileModel profile) {
    return 30; // minutos por día
  }

  static List<String> _generateRecommendations(FitnessProfileModel profile) {
    List<String> recommendations = [];
    
    if (profile.currentWaterGlasses < 6) {
      recommendations.add('Aumenta tu consumo de agua gradualmente');
    }
    
    if (profile.currentSleepHours < 7) {
      recommendations.add('Mejora tus hábitos de sueño');
    }
    
    if (profile.screenTimeHours > 8) {
      recommendations.add('Reduce el tiempo de pantalla');
    }
    
    return recommendations;
  }
}