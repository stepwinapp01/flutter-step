import 'package:flutter/material.dart';
import '../../shared/services/mock_data_service.dart';

/// Pantalla de metas diarias
class GoalsScreen extends StatelessWidget {
  final String language;
  
  const GoalsScreen({
    super.key,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final todayGoals = MockDataService.todayGoals;
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Metas Diarias',
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
          children: [
            _buildGoalCard(
              'Pasos',
              '${todayGoals.steps}',
              '${todayGoals.targetSteps}',
              todayGoals.steps / todayGoals.targetSteps,
              Icons.directions_walk,
              const Color(0xFF10B981),
              'pasos',
            ),
            const SizedBox(height: 16),
            _buildGoalCard(
              'Sueño',
              '${todayGoals.sleepHours.toStringAsFixed(1)}h',
              '${todayGoals.targetSleepHours.toStringAsFixed(1)}h',
              todayGoals.sleepHours / todayGoals.targetSleepHours,
              Icons.bedtime,
              const Color(0xFF3B82F6),
              'horas',
            ),
            const SizedBox(height: 16),
            _buildGoalCard(
              'Agua',
              '${todayGoals.waterLiters.toStringAsFixed(1)}L',
              '${todayGoals.targetWaterLiters.toStringAsFixed(1)}L',
              todayGoals.waterLiters / todayGoals.targetWaterLiters,
              Icons.water_drop,
              const Color(0xFF06B6D4),
              'litros',
            ),
            const SizedBox(height: 16),
            _buildGoalCard(
              'Meditación',
              '${todayGoals.meditationMinutes} min',
              '${todayGoals.targetMeditationMinutes} min',
              todayGoals.meditationMinutes / todayGoals.targetMeditationMinutes,
              Icons.self_improvement,
              const Color(0xFF8B5CF6),
              'minutos',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(
    String title,
    String current,
    String target,
    double progress,
    IconData icon,
    Color color,
    String unit,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      Text(
                        '$current de $target',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '${(progress * 100).clamp(0, 100).toInt()}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                progress >= 1.0 ? '¡Meta completada!' : 'En progreso',
                style: TextStyle(
                  fontSize: 12,
                  color: progress >= 1.0 ? color : Colors.grey.shade600,
                  fontWeight: progress >= 1.0 ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              if (progress >= 1.0)
                Icon(Icons.check_circle, color: color, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}