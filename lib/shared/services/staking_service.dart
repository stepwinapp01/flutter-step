import 'validation_service.dart';

/// Servicio de Staking para Step Win (Mock)
/// 
/// Maneja recompensas, penalizaciones y liquidez del sistema de tokens
class StakingService {
  /// Calcula recompensas de staking diarias
  static double calculateDailyRewards(double stakedAmount, int userLevel, String plan) {
    final baseRate = _getBaseRewardRate(plan);
    final levelMultiplier = _getLevelMultiplier(userLevel);
    
    return stakedAmount * baseRate * levelMultiplier / 365; // APY diario
  }
  
  /// Procesa staking de tokens
  static StakingResult processStaking(double tokenAmount, int userLevel, double currentStaked) {
    final validation = ValidationService.validateStaking(tokenAmount, userLevel);
    
    if (!validation.isValid) {
      return StakingResult(false, validation.message, 0.0);
    }
    
    final newStakedAmount = currentStaked + tokenAmount;
    final lockPeriod = _getLockPeriod(userLevel);
    
    return StakingResult(
      true, 
      'Staking exitoso. Bloqueado por $lockPeriod días',
      newStakedAmount,
    );
  }
  
  /// Calcula penalización por retiro anticipado
  static double calculateEarlyWithdrawalPenalty(double stakedAmount, DateTime stakeDate) {
    final daysSinceStake = DateTime.now().difference(stakeDate).inDays;
    const requiredDays = 30; // Período mínimo de staking
    
    if (daysSinceStake >= requiredDays) return 0.0;
    
    final remainingDays = requiredDays - daysSinceStake;
    final penaltyRate = remainingDays / requiredDays * 0.25; // Hasta 25%
    
    return stakedAmount * penaltyRate;
  }
  
  /// Procesa unstaking con validaciones
  static UnstakingResult processUnstaking(double amount, double stakedAmount, DateTime stakeDate) {
    if (amount > stakedAmount) {
      return const UnstakingResult(false, 'Cantidad excede tokens en staking', 0.0, 0.0);
    }
    
    final penalty = calculateEarlyWithdrawalPenalty(amount, stakeDate);
    final netAmount = amount - penalty;
    
    return UnstakingResult(
      true,
      penalty > 0 ? 'Retiro con penalización de ${penalty.toStringAsFixed(2)} tokens' : 'Retiro exitoso',
      netAmount,
      penalty,
    );
  }
  
  /// Calcula liquidez disponible del pool
  static double calculatePoolLiquidity(List<StakePosition> allPositions) {
    final totalStaked = allPositions.fold(0.0, (sum, pos) => sum + pos.amount);
    const reserveRatio = 0.20; // 20% de reserva
    
    return totalStaked * reserveRatio;
  }
  
  /// Tasa base de recompensas por plan
  static double _getBaseRewardRate(String plan) {
    switch (plan) {
      case 'basic': return 0.05; // 5% APY
      case 'pro': return 0.08;   // 8% APY
      case 'elite': return 0.12; // 12% APY
      default: return 0.05;
    }
  }
  
  /// Multiplicador por nivel
  static double _getLevelMultiplier(int level) {
    return 1.0 + (level - 1) * 0.02; // +2% por nivel
  }
  
  /// Período de bloqueo por nivel
  static int _getLockPeriod(int level) {
    if (level >= 7) return 90;  // 3 meses
    if (level >= 4) return 60;  // 2 meses
    return 30; // 1 mes
  }
}

/// Resultado de operación de staking
class StakingResult {
  final bool success;
  final String message;
  final double newStakedAmount;
  
  const StakingResult(this.success, this.message, this.newStakedAmount);
}

/// Resultado de unstaking
class UnstakingResult {
  final bool success;
  final String message;
  final double netAmount;
  final double penalty;
  
  const UnstakingResult(this.success, this.message, this.netAmount, this.penalty);
}

/// Posición de staking
class StakePosition {
  final String userId;
  final double amount;
  final DateTime stakeDate;
  final int lockPeriod;
  
  const StakePosition({
    required this.userId,
    required this.amount,
    required this.stakeDate,
    required this.lockPeriod,
  });
}