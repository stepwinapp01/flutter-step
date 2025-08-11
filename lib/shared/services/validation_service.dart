/// Servicio de validaciones para Step Win App (Mock)
/// 
/// Implementa todas las validaciones de negocio en modo simulado
class ValidationService {
  /// Valida edad mínima (16 años) y autorización parental
  static ValidationResult validateAge(DateTime birthDate, bool parentalConsent) {
    final age = DateTime.now().difference(birthDate).inDays ~/ 365;
    
    if (age < 16) {
      return const ValidationResult(false, 'Edad mínima requerida: 16 años');
    }
    
    if (age >= 16 && age < 18 && !parentalConsent) {
      return const ValidationResult(false, 'Autorización parental requerida para menores de 18');
    }
    
    return const ValidationResult(true, 'Edad válida');
  }
  
  /// Valida si el reconocimiento facial es requerido
  static bool requiresFacialRecognition(int userLevel) {
    return userLevel >= 2;
  }
  
  /// Valida requisitos para subir de nivel
  static ValidationResult validateLevelUp(int currentLevel, String plan, int activeUsers) {
    final requirements = _getLevelRequirements(currentLevel + 1);
    
    if (!_isPlanEligible(plan, currentLevel + 1)) {
      return ValidationResult(false, 'Plan ${plan.toUpperCase()} requerido para nivel ${currentLevel + 1}');
    }
    
    if (activeUsers < requirements['minActiveUsers']) {
      return ValidationResult(false, 'Mínimo ${requirements['minActiveUsers']} usuarios activos requeridos');
    }
    
    return ValidationResult(true, 'Requisitos cumplidos para nivel ${currentLevel + 1}');
  }
  
  /// Valida staking para recompensas
  static ValidationResult validateStaking(double tokenAmount, int userLevel) {
    final minStake = _getMinStakeForLevel(userLevel);
    
    if (tokenAmount < minStake) {
      return ValidationResult(false, 'Staking mínimo: $minStake tokens para nivel $userLevel');
    }
    
    return const ValidationResult(true, 'Staking válido');
  }
  
  /// Calcula penalización por inactividad
  static double calculateInactivityPenalty(DateTime lastActive, double stakedTokens) {
    final daysSinceActive = DateTime.now().difference(lastActive).inDays;
    
    if (daysSinceActive <= 7) return 0.0;
    if (daysSinceActive <= 14) return stakedTokens * 0.05; // 5%
    if (daysSinceActive <= 30) return stakedTokens * 0.15; // 15%
    
    return stakedTokens * 0.30; // 30% máximo
  }
  
  /// Requisitos por nivel (Datos oficiales de la tabla)
  static Map<String, dynamic> _getLevelRequirements(int level) {
    final requirements = {
      1: {'minActiveUsers': 0, 'subscription': 11, 'maxEarnings': 0, 'minWithdraw': 0},
      2: {'minActiveUsers': 3, 'subscription': 11, 'maxEarnings': 5, 'minWithdraw': 50},
      3: {'minActiveUsers': 5, 'subscription': 18, 'maxEarnings': 15, 'minWithdraw': 100},
      4: {'minActiveUsers': 10, 'subscription': 18, 'maxEarnings': 30, 'minWithdraw': 200},
      5: {'minActiveUsers': 20, 'subscription': 25, 'maxEarnings': 50, 'minWithdraw': 350},
      6: {'minActiveUsers': 30, 'subscription': 25, 'maxEarnings': 75, 'minWithdraw': 500},
      7: {'minActiveUsers': 50, 'subscription': 25, 'maxEarnings': 100, 'minWithdraw': 750},
      8: {'minActiveUsers': 80, 'subscription': 25, 'maxEarnings': 150, 'minWithdraw': 1000},
      9: {'minActiveUsers': 90, 'subscription': 25, 'maxEarnings': 200, 'minWithdraw': 1500},
      10: {'minActiveUsers': 100, 'subscription': 25, 'maxEarnings': 300, 'minWithdraw': 2000},
    };
    
    return requirements[level] ?? {'minActiveUsers': 0, 'subscription': 11, 'maxEarnings': 0, 'minWithdraw': 0};
  }
  
  /// Verifica elegibilidad de suscripción
  static bool _isPlanEligible(String userPlan, int targetLevel) {
    final requiredSubscription = _getLevelRequirements(targetLevel)['subscription'];
    final planValues = {'basic': 11, 'pro': 18, 'elite': 25};
    
    return planValues[userPlan]! >= requiredSubscription;
  }
  
  /// Staking mínimo por nivel
  static double _getMinStakeForLevel(int level) {
    final stakes = {
      1: 0.0, 2: 10.0, 3: 25.0, 4: 50.0, 5: 100.0,
      6: 200.0, 7: 400.0, 8: 800.0, 9: 1500.0, 10: 3000.0
    };
    
    return stakes[level] ?? 0.0;
  }
}

/// Resultado de validación
class ValidationResult {
  final bool isValid;
  final String message;
  
  const ValidationResult(this.isValid, this.message);
}