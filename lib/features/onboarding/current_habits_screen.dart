import 'package:flutter/material.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';
import 'coach_plan_screen.dart';

class CurrentHabitsScreen extends StatefulWidget {
  const CurrentHabitsScreen({super.key});

  @override
  State<CurrentHabitsScreen> createState() => _CurrentHabitsScreenState();
}

class _CurrentHabitsScreenState extends State<CurrentHabitsScreen> {
  // Hidratación
  int waterGlasses = 2;
  
  // Actividad física
  int dailySteps = 2000;
  
  // Meditación/Oración
  int meditationMinutes = 0;
  String meditationType = 'meditacion';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressIndicator(
              currentStep: 5,
              totalSteps: 13,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '¿Cuáles son tus hábitos actuales?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Esto ayudará al Coach Adán a crear tu plan personalizado',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Hidratación
                    _buildHabitSection(
                      'Hidratación',
                      'vasos de agua al día',
                      Icons.local_drink,
                      const Color(0xFF3B82F6),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: waterGlasses > 0 ? () {
                                  setState(() => waterGlasses--);
                                } : null,
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3B82F6).withAlpha(26),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '$waterGlasses vasos',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: waterGlasses < 15 ? () {
                                  setState(() => waterGlasses++);
                                } : null,
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Actividad física
                    _buildHabitSection(
                      'Actividad Física',
                      'pasos promedio al día',
                      Icons.directions_walk,
                      const Color(0xFF10B981),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: dailySteps > 0 ? () {
                                  setState(() => dailySteps = (dailySteps - 500).clamp(0, 20000));
                                } : null,
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withAlpha(26),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${dailySteps.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} pasos',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: dailySteps < 20000 ? () {
                                  setState(() => dailySteps = (dailySteps + 500).clamp(0, 20000));
                                } : null,
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Meditación/Oración
                    _buildHabitSection(
                      'Bienestar Mental',
                      'tiempo de práctica diaria',
                      Icons.self_improvement,
                      const Color(0xFF8B5CF6),
                      Column(
                        children: [
                          // Tipo de práctica
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => meditationType = 'meditacion'),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: meditationType == 'meditacion' 
                                          ? const Color(0xFF8B5CF6) 
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Meditación',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: meditationType == 'meditacion' 
                                            ? Colors.white 
                                            : Colors.grey.shade600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => meditationType = 'oracion'),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: meditationType == 'oracion' 
                                          ? const Color(0xFF8B5CF6) 
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Oración',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: meditationType == 'oracion' 
                                            ? Colors.white 
                                            : Colors.grey.shade600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Tiempo
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: meditationMinutes > 0 ? () {
                                  setState(() => meditationMinutes = (meditationMinutes - 5).clamp(0, 120));
                                } : null,
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B5CF6).withAlpha(26),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  meditationMinutes == 0 ? 'No practico' : '$meditationMinutes min',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: meditationMinutes < 120 ? () {
                                  setState(() => meditationMinutes = (meditationMinutes + 5).clamp(0, 120));
                                } : null,
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CoachPlanScreen(
                                currentHabits: {
                                  'waterGlasses': waterGlasses,
                                  'dailySteps': dailySteps,
                                  'meditationMinutes': meditationMinutes,
                                  'meditationType': meditationType,
                                },
                              ),
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

  Widget _buildHabitSection(String title, String subtitle, IconData icon, Color color, Widget content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
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
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          content,
        ],
      ),
    );
  }
}