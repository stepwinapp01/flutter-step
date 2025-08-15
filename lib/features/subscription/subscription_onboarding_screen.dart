import 'package:flutter/material.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';
import '../levels/levels_system_screen.dart';

class SubscriptionOnboardingScreen extends StatefulWidget {
  const SubscriptionOnboardingScreen({super.key});

  @override
  State<SubscriptionOnboardingScreen> createState() => _SubscriptionOnboardingScreenState();
}

class _SubscriptionOnboardingScreenState extends State<SubscriptionOnboardingScreen> {
  String _selectedPlan = 'basic';

  final List<Map<String, dynamic>> _plans = [
    {
      'id': 'basic',
      'name': 'Básico',
      'price': '\$11/mes',
      'color': Colors.grey,
      'features': [
        'Seguimiento básico de pasos',
        'Coach IA limitado',
        'Recompensas básicas',
        'Comunidad básica',
      ],
    },
    {
      'id': 'pro',
      'name': 'Pro',
      'price': '\$18/mes',
      'color': const Color(0xFF6B46C1),
      'features': [
        'Seguimiento completo',
        'Coach IA avanzado',
        'Recompensas premium',
        'Análisis detallados',
        'Sin anuncios',
      ],
    },
    {
      'id': 'elite',
      'name': 'Elite',
      'price': '\$25/mes',
      'color': const Color(0xFFD97706),
      'features': [
        'Todo lo de Pro',
        'Planes personalizados',
        'Soporte prioritario',
        'Retiros sin comisión',
        'Acceso beta',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgressIndicator(currentStep: 8, totalSteps: 13),
              const SizedBox(height: 32),
              const Text(
                'Elige tu plan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Selecciona el plan que mejor se adapte a tus objetivos',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: _plans.length,
                  itemBuilder: (context, index) {
                    final plan = _plans[index];
                    final isSelected = _selectedPlan == plan['id'];
                    
                    return GestureDetector(
                      onTap: () => setState(() => _selectedPlan = plan['id']),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isSelected ? plan['color'].withOpacity(0.1) : Colors.grey.shade50,
                          border: Border.all(
                            color: isSelected ? plan['color'] : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plan['name'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? plan['color'] : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      plan['price'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected ? plan['color'] : Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: plan['color'],
                                    size: 28,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ...plan['features'].map<Widget>((feature) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    size: 16,
                                    color: isSelected ? plan['color'] : Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isSelected ? plan['color'] : Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )).toList(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Continuar con ${_plans.firstWhere((p) => p['id'] == _selectedPlan)['name']}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),

            ],
          ),
        ),
      ),
    );
  }

  void _continue() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LevelsSystemScreen(isOnboarding: true),
      ),
    );
  }
}