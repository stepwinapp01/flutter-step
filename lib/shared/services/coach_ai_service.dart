import '../models/fitness_profile_model.dart';
import '../models/fitness_plan_model.dart';

/// Servicio de Coach IA Adán (Mock)
/// 
/// Maneja motivación, recuperación de usuarios inactivos y seguimiento
class CoachAIService {
  /// Genera mensaje de bienvenida con plan personalizado
  static String generateWelcomeWithPlan(FitnessPlanModel plan) {
    return '''¡Hola! Soy Coach Adán y he creado tu plan personalizado: "${plan.planName}" 🎯

📊 Tus metas iniciales:
• ${plan.targetSteps} pasos diarios
• ${plan.targetWaterLiters}L de agua
• ${plan.targetSleepHours}h de sueño
• Máximo ${plan.maxScreenTimeHours}h de pantalla

¡Empezaremos gradualmente y ajustaremos según tu progreso! ¿Listo para comenzar?''';
  }
  
  /// Genera mensaje motivacional basado en progreso
  static String generateMotivationalMessage(int level, double tokenBalance, DateTime lastActive) {
    final daysSinceActive = DateTime.now().difference(lastActive).inDays;
    
    if (daysSinceActive > 3) {
      return _getInactivityRecoveryMessage(daysSinceActive);
    }
    
    if (tokenBalance < 50) {
      return _getLowTokensMotivation(level);
    }
    
    return _getProgressMotivation(level);
  }
  
  /// Evalúa riesgo de abandono del usuario
  static UserRetentionRisk evaluateRetentionRisk(DateTime lastActive, int level, double tokenBalance) {
    final daysSinceActive = DateTime.now().difference(lastActive).inDays;
    
    if (daysSinceActive >= 14) return UserRetentionRisk.high;
    if (daysSinceActive >= 7) return UserRetentionRisk.medium;
    if (tokenBalance < 10 && level < 3) return UserRetentionRisk.medium;
    
    return UserRetentionRisk.low;
  }
  
  /// Genera plan de recuperación personalizado
  static RecoveryPlan generateRecoveryPlan(UserRetentionRisk risk, int level) {
    switch (risk) {
      case UserRetentionRisk.high:
        return const RecoveryPlan(
          bonusTokens: 20.0,
          specialChallenge: 'Camina 5000 pasos hoy y gana tokens extra',
          coachMessage: '¡Te extrañé! Volvamos juntos al camino del bienestar 💪',
        );
      case UserRetentionRisk.medium:
        return const RecoveryPlan(
          bonusTokens: 10.0,
          specialChallenge: 'Completa tu meta diaria de agua',
          coachMessage: 'Mantengamos el momentum. ¡Tú puedes! 🚀',
        );
      case UserRetentionRisk.low:
        return const RecoveryPlan(
          bonusTokens: 5.0,
          specialChallenge: 'Medita 5 minutos hoy',
          coachMessage: '¡Excelente progreso! Sigamos así 🌟',
        );
    }
  }
  
  /// Mensajes de recuperación por inactividad
  static String _getInactivityRecoveryMessage(int daysSinceActive) {
    if (daysSinceActive >= 30) {
      return '¡Hola de nuevo! 🎉 Te he preparado un plan especial para retomar tu rutina. ¡Empecemos paso a paso!';
    }
    if (daysSinceActive >= 14) {
      return '¡Te extrañé! 💙 ¿Qué tal si empezamos con una caminata corta? Tu bienestar me importa.';
    }
    if (daysSinceActive >= 7) {
      return '¡Hola! 👋 Noto que has estado ausente. ¿Todo bien? Estoy aquí para apoyarte.';
    }
    
    return '¡Bienvenido de vuelta! ¿Listo para continuar tu progreso? 🚀';
  }
  
  /// Motivación por tokens bajos
  static String _getLowTokensMotivation(int level) {
    return 'Veo que tus tokens están bajos. ¡Perfecto momento para una sesión de ejercicio! 💪 Cada paso cuenta.';
  }
  
  /// Motivación por progreso
  static String _getProgressMotivation(int level) {
    final messages = [
      '¡Increíble progreso en nivel $level! 🌟 Tu constancia está dando frutos.',
      '¡Vas genial! Nivel $level desbloqueado. ¿Listo para el siguiente desafío? 🎯',
      'Tu dedicación en nivel $level es inspiradora. ¡Sigamos construyendo hábitos! 🏗️',
    ];
    
    return messages[level % messages.length];
  }
}

/// Niveles de riesgo de retención
enum UserRetentionRisk { low, medium, high }

/// Plan de recuperación personalizado
class RecoveryPlan {
  final double bonusTokens;
  final String specialChallenge;
  final String coachMessage;
  
  const RecoveryPlan({
    required this.bonusTokens,
    required this.specialChallenge,
    required this.coachMessage,
  });
}

/// Genera plan de acondicionamiento físico personalizado
class FitnessPlanGenerator {
  /// Crea plan personalizado basado en perfil del usuario
  static FitnessPlanModel generatePersonalizedPlan(FitnessProfileModel profile) {
    final planName = _getPlanName(profile);
    final baseTargets = _calculateBaseTargets(profile);
    final recommendations = _generateRecommendations(profile);
    final weeklyProgression = _createWeeklyProgression(profile, baseTargets);
    
    return FitnessPlanModel(
      id: 'plan_${profile.userId}_${DateTime.now().millisecondsSinceEpoch}',
      userId: profile.userId,
      planName: planName,
      targetSteps: baseTargets['steps']! as int,
      targetWaterLiters: baseTargets['water']!.toDouble(),
      targetSleepHours: baseTargets['sleep']!.toDouble(),
      maxScreenTimeHours: baseTargets['screenTime']! as int,
      recommendations: recommendations,
      weeklyProgression: weeklyProgression,
      createdAt: DateTime.now(),
      validUntil: DateTime.now().add(const Duration(days: 30)),
    );
  }
  
  /// Determina nombre del plan según perfil
  static String _getPlanName(FitnessProfileModel profile) {
    if (profile.activityLevel == 'sedentary') {
      return 'Plan Despertar - Activación Gradual';
    } else if (profile.bmi > 30) {
      return 'Plan Transformación - Pérdida de Peso';
    } else if (profile.currentWalkingMinutes * 100 < 3000) {
      return 'Plan Movimiento - Hábitos Básicos';
    }
    return 'Plan Equilibrio - Vida Saludable';
  }
  
  /// Calcula metas base según perfil
  static Map<String, num> _calculateBaseTargets(FitnessProfileModel profile) {
    int targetSteps = 5000; // Base mínima
    double targetWater = 2.0;
    double targetSleep = 7.0;
    int maxScreenTime = 6;
    
    // Ajustar según nivel de actividad (convertir minutos a pasos aproximados)
    switch (profile.activityLevel) {
      case 'sedentary':
        targetSteps = (profile.currentWalkingMinutes + 10) * 100; // ~100 pasos por minuto
        maxScreenTime = profile.screenTimeHours - 1;
        break;
      case 'light':
        targetSteps = 7000;
        maxScreenTime = 5;
        break;
      case 'moderate':
        targetSteps = 9000;
        maxScreenTime = 4;
        break;
      case 'active':
        targetSteps = 12000;
        maxScreenTime = 3;
        break;
    }
    
    // Ajustar vasos de agua por peso (más vasos para mayor peso)
    targetWater = 8.0 + (profile.weight - 70) * 0.02;
    
    // Ajustar sueño por edad
    if (profile.age < 25) targetSleep = 8.0;
    if (profile.age > 50) targetSleep = 7.5;
    
    return {
      'steps': targetSteps.clamp(3000, 15000),
      'water': targetWater.clamp(6, 12), // vasos de agua
      'sleep': targetSleep.clamp(6.0, 9.0),
      'screenTime': maxScreenTime.clamp(2, 8),
    };
  }
  
  /// Genera recomendaciones personalizadas
  static List<String> _generateRecommendations(FitnessProfileModel profile) {
    final recommendations = <String>[];
    
    // Recomendaciones por BMI
    if (profile.bmi < 18.5) {
      recommendations.add('🍎 Aumenta tu ingesta calórica con alimentos nutritivos');
      recommendations.add('💪 Incluye ejercicios de fuerza para ganar masa muscular');
    } else if (profile.bmi > 25) {
      recommendations.add('🚶 Incrementa gradualmente tu actividad física diaria');
      recommendations.add('🥗 Enfócate en una alimentación balanceada y controlada');
    }
    
    // Recomendaciones por actividad
    if (profile.activityLevel == 'sedentary') {
      recommendations.add('⏰ Levántate cada hora y camina 2-3 minutos');
      recommendations.add('🚶 Comienza con caminatas de 10 minutos después de comer');
    }
    
    // Recomendaciones por tiempo de pantalla
    if (profile.screenTimeHours > 8) {
      recommendations.add('📱 Implementa la regla 20-20-20: cada 20 min, mira algo a 20 metros por 20 segundos');
      recommendations.add('🌅 Evita pantallas 1 hora antes de dormir');
    }
    
    // Recomendaciones por sueño
    if (profile.currentSleepHours < 7) {
      recommendations.add('😴 Establece una rutina de sueño consistente');
      recommendations.add('🛏️ Crea un ambiente oscuro y fresco para dormir');
    }
    
    // Recomendaciones por hidratación
    if (profile.currentWaterGlasses < 6) {
      recommendations.add('💧 Lleva una botella de agua contigo siempre');
      recommendations.add('⏰ Programa recordatorios para beber agua cada 2 horas');
    }
    
    // Recomendaciones por meditación/oración
    if (profile.currentMeditationMinutes < 10) {
      recommendations.add('🙏 Dedica al menos 10 minutos diarios a la meditación o oración');
      recommendations.add('🌅 Comienza el día con 5 minutos de reflexión o gratitud');
    }
    
    return recommendations;
  }
  
  /// Crea progresión semanal del plan
  static List<WeeklyGoal> _createWeeklyProgression(FitnessProfileModel profile, Map<String, num> targets) {
    final progression = <WeeklyGoal>[];
    final baseSteps = (profile.currentWalkingMinutes * 100).clamp(1000, 20000); // Convertir minutos a pasos aproximados
    final targetSteps = (targets['steps']! as int).clamp(3000, 15000);
    final stepIncrement = ((targetSteps - baseSteps) / 4).round().abs();
    
    for (int week = 1; week <= 4; week++) {
      final calculatedSteps = baseSteps + (stepIncrement * week);
      final minSteps = baseSteps < targetSteps ? baseSteps : targetSteps;
      final maxSteps = baseSteps > targetSteps ? baseSteps : targetSteps;
      final weekSteps = calculatedSteps.clamp(minSteps, maxSteps);
      final weekWater = (targets['water']! as double) * (0.7 + (week * 0.075));
      final weekSleep = targets['sleep']! as double;
      final weekScreenTime = (targets['screenTime']! as int) + (4 - week);
      
      String focus;
      switch (week) {
        case 1:
          focus = 'Adaptación y creación de hábitos';
          break;
        case 2:
          focus = 'Incremento gradual de actividad';
          break;
        case 3:
          focus = 'Consolidación de rutinas';
          break;
        case 4:
          focus = 'Optimización y mantenimiento';
          break;
        default:
          focus = 'Progreso continuo';
      }
      
      progression.add(WeeklyGoal(
        week: week,
        steps: weekSteps,
        water: weekWater.clamp(1.5, 4.0),
        sleep: weekSleep,
        screenTime: weekScreenTime.clamp(2, 12),
        focus: focus,
      ));
    }
    
    return progression;
  }
}