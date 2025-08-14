import 'package:flutter/material.dart';
import '../../shared/services/mock_data_service.dart';
import '../../shared/constants/app_icons.dart';

/// Pantalla de recompensas y tokens
class RewardsScreen extends StatelessWidget {
  final String language;
  
  const RewardsScreen({
    super.key,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final user = MockDataService.currentUser;
    final withdrawalHistory = MockDataService.withdrawalHistory;
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Recompensas',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance de tokens
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B46C1), Color(0xFF9333EA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    AppIcons.stars,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Balance de Tokens',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${user.tokenBalance.toStringAsFixed(2)} SWT',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '≈ \$${(user.tokenBalance * 0.1).toStringAsFixed(2)} USD',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Botones de acción
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    'Retirar',
                    AppIcons.accountBalanceWallet,
                    const Color(0xFF10B981),
                    () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    'Historial',
                    AppIcons.history,
                    const Color(0xFF3B82F6),
                    () {},
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Historial de retiros
            const Text(
              'Historial de Retiros',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            
            const SizedBox(height: 16),
            
            ...withdrawalHistory.map((withdrawal) => _buildWithdrawalItem(
              withdrawal['amount'].toString(),
              withdrawal['currency'],
              withdrawal['status'],
              withdrawal['date'],
            )),
            
            const SizedBox(height: 30),
            
            // Formas de ganar tokens
            const Text(
              'Formas de Ganar Tokens',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            
            const SizedBox(height: 16),
            
            _buildEarnTokenItem(
              'Caminar 1,000 pasos',
              '10 tokens',
              AppIcons.directionsWalk,
              const Color(0xFF10B981),
            ),
            _buildEarnTokenItem(
              'Dormir 7+ horas',
              '50 tokens',
              AppIcons.bedtime,
              const Color(0xFF3B82F6),
            ),
            _buildEarnTokenItem(
              'Beber 2L de agua',
              '30 tokens',
              AppIcons.waterDrop,
              const Color(0xFF06B6D4),
            ),
            _buildEarnTokenItem(
              'Meditar 10 minutos',
              '40 tokens',
              AppIcons.selfImprovement,
              const Color(0xFF8B5CF6),
            ),
            _buildEarnTokenItem(
              'Chat con Coach Adán',
              '60 tokens',
              AppIcons.psychology,
              const Color(0xFF6B46C1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithdrawalItem(
    String amount,
    String currency,
    String status,
    DateTime date,
  ) {
    Color statusColor;
    String statusText;
    
    switch (status) {
      case 'completed':
        statusColor = const Color(0xFF10B981);
        statusText = 'Completado';
        break;
      case 'pending':
        statusColor = const Color(0xFFF59E0B);
        statusText = 'Pendiente';
        break;
      default:
        statusColor = const Color(0xFFEF4444);
        statusText = 'Fallido';
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              AppIcons.accountBalanceWallet,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$amount $currency',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              statusText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarnTokenItem(
    String activity,
    String reward,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              activity,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Text(
            reward,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}