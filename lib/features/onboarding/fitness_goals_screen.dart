import 'package:flutter/material.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';
import 'coach_plan_screen.dart';

class FitnessGoalsScreen extends StatefulWidget {
  const FitnessGoalsScreen({super.key});

  @override
  State<FitnessGoalsScreen> createState() => _FitnessGoalsScreenState();
}

class _FitnessGoalsScreenState extends State<FitnessGoalsScreen> {
  final Set<String> _selectedGoals = {};

  final List<Map<String, dynamic>> _goals = [
    {'id': 'weight_loss', 'title': 'Perder peso', 'icon': Icons.trending_down},
    {'id': 'muscle_gain', 'title': 'Ganar músculo', 'icon': Icons.fitness_center},
    {'id': 'endurance', 'title': 'Mejorar resistencia', 'icon': Icons.directions_run},
    {'id': 'flexibility', 'title': 'Aumentar flexibilidad', 'icon': Icons.self_improvement},
    {'id': 'health', 'title': 'Mejorar salud general', 'icon': Icons.favorite},
    {'id': 'stress', 'title': 'Reducir estrés', 'icon': Icons.spa},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnboardingProgressIndicator(currentStep: 6, totalSteps: 13),
                  const SizedBox(height: 32),
                  const Text(
                    '¿Cuáles son tus objetivos?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Selecciona uno o más objetivos para personalizar tu experiencia',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: _goals.length,
                  itemBuilder: (context, index) {
                    final goal = _goals[index];
                    final isSelected = _selectedGoals.contains(goal['id']);
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedGoals.remove(goal['id']);
                          } else {
                            _selectedGoals.add(goal['id']);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF6B46C1).withOpacity(0.1) : Colors.grey.shade50,
                          border: Border.all(
                            color: isSelected ? const Color(0xFF6B46C1) : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              goal['icon'],
                              size: 40,
                              color: isSelected ? const Color(0xFF6B46C1) : Colors.grey.shade600,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              goal['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? const Color(0xFF6B46C1) : Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedGoals.isNotEmpty ? _continue : null,
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _continue() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CoachPlanScreen(currentHabits: {}),
      ),
    );
  }
}