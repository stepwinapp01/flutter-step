import 'package:flutter/material.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';
import '../subscription/subscription_onboarding_screen.dart';

class CoachPlanScreen extends StatelessWidget {
  final Map<String, dynamic> currentHabits;
  
  const CoachPlanScreen({super.key, required this.currentHabits});

  Map<String, dynamic> _generatePersonalizedPlan() {
    final waterCurrent = currentHabits['waterGlasses'] ?? 2;
    final stepsCurrent = currentHabits['dailySteps'] ?? 2000;
    final meditationCurrent = currentHabits['meditationMinutes'] ?? 0;
    final meditationType = currentHabits['meditationType'] ?? 'meditacion';

    // Incremento gradual basado en hábitos actuales
    final waterTarget = (waterCurrent + 2).clamp(6, 10);
    final stepsTarget = (stepsCurrent + 1000).clamp(5000, 12000);
    final meditationTarget = meditationCurrent == 0 ? 5 : (meditationCurrent + 5).clamp(5, 20);

    return {
      'waterTarget': waterTarget,
      'stepsTarget': stepsTarget,
      'meditationTarget': meditationTarget,
      'meditationType': meditationType,
      'waterMessage': waterCurrent < 4 ? 'Incremento gradual para mejorar hidratación' : 'Mantener buen nivel de hidratación',
      'stepsMessage': stepsCurrent < 5000 ? 'Aumento progresivo de actividad física' : 'Mantener ritmo activo saludable',
      'meditationMessage': meditationCurrent == 0 ? 'Iniciar práctica de bienestar mental' : 'Profundizar práctica existente',
      'motivationalMessage': 'Recuerda: pequeños cambios consistentes generan grandes resultados. ¡Tú puedes lograrlo!'
    };
  }

  @override
  Widget build(BuildContext context) {
    final plan = _generatePersonalizedPlan();
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressIndicator(
              currentStep: 6,
              totalSteps: 13,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tu Plan Personalizado',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Coach Adán ha creado este plan especialmente para ti',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Coach Adán Avatar
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6B46C1), Color(0xFF8B5CF6)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.psychology, color: Colors.white, size: 30),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Coach Adán', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                              Text('Tu entrenador personal con IA', style: TextStyle(fontSize: 14, color: Colors.white70)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Plan personalizado
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('🎯 Tu Plan Semanal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          
                          _buildPlanItem(Icons.local_drink, 'Hidratación', '${plan['waterTarget']} vasos diarios', plan['waterMessage'], const Color(0xFF3B82F6)),
                          const SizedBox(height: 16),
                          _buildPlanItem(Icons.directions_walk, 'Actividad', '${plan['stepsTarget']} pasos diarios', plan['stepsMessage'], const Color(0xFF10B981)),
                          const SizedBox(height: 16),
                          _buildPlanItem(Icons.self_improvement, 'Bienestar', '${plan['meditationTarget']} min de ${plan['meditationType']}', plan['meditationMessage'], const Color(0xFF8B5CF6)),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.lightbulb, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 12),
                          Expanded(child: Text(plan['motivationalMessage'], style: const TextStyle(color: Color(0xFF92400E)))),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SubscriptionOnboardingScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B46C1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Continuar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanItem(IconData icon, String title, String target, String message, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(26),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(target, style: const TextStyle(fontSize: 14, color: Color(0xFF6B46C1))),
                Text(message, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}