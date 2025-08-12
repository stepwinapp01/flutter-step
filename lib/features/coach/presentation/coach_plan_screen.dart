import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/fitness_plan_model.dart';
import '../../../shared/services/coach_ai_service.dart';
import '../../main_app/main_tabs_screen.dart';

/// Pantalla que muestra el plan personalizado de Coach Adán
class CoachPlanScreen extends StatelessWidget {
  final FitnessPlanModel plan;

  const CoachPlanScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header con Coach Adán
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppConstants.primaryPurple, AppConstants.secondaryPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      '🤖',
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Coach Adán',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tu entrenador personal de IA',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            // Contenido del plan
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mensaje de bienvenida
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Text(
                        CoachAIService.generateWelcomeWithPlan(plan),
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Metas principales
                    const Text(
                      '🎯 Tus Metas Principales',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(child: _buildGoalCard('🚶', '${plan.targetSteps}', 'Pasos diarios')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildGoalCard('💧', '${plan.targetWaterLiters}L', 'Agua diaria')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildGoalCard('😴', '${plan.targetSleepHours}h', 'Sueño nocturno')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildGoalCard('📱', '${plan.maxScreenTimeHours}h', 'Máx. pantalla')),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Recomendaciones
                    const Text(
                      '💡 Recomendaciones Personalizadas',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    
                    ...plan.recommendations.map((rec) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.lightbulb, color: Colors.orange, size: 20),
                          const SizedBox(width: 8),
                          Expanded(child: Text(rec, style: const TextStyle(fontSize: 14))),
                        ],
                      ),
                    )).toList(),
                    
                    const SizedBox(height: 24),
                    
                    // Progresión semanal
                    const Text(
                      '📈 Progresión de 4 Semanas',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    
                    ...plan.weeklyProgression.map((week) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Semana ${week.week}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.primaryPurple,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            week.focus,
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(child: Text('🚶 ${week.steps} pasos', style: const TextStyle(fontSize: 12))),
                              Expanded(child: Text('💧 ${week.water.toStringAsFixed(1)}L', style: const TextStyle(fontSize: 12))),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text('😴 ${week.sleep.toStringAsFixed(1)}h', style: const TextStyle(fontSize: 12))),
                              Expanded(child: Text('📱 ${week.screenTime}h máx', style: const TextStyle(fontSize: 12))),
                            ],
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
            ),
            
            // Botón para comenzar
            Container(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MainTabsScreen(language: 'es')),
                    (route) => false,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    '🚀 ¡Comenzar Mi Transformación!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(String emoji, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          AppConstants.primaryPurple.withAlpha((0.1 * 255).toInt()), 
          Colors.white
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color.alphaBlend(
            AppConstants.primaryPurple.withAlpha((0.3 * 255).toInt()), 
            Colors.white
          ),
        ),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryPurple,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}