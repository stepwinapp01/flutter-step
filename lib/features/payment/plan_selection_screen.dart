import 'package:flutter/material.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';
import '../../shared/services/mock_data_service.dart';
import '../onboarding/level_terms_screen.dart';

/// Pantalla de selección de plan de suscripción
class PlanSelectionScreen extends StatefulWidget {
  final String language;
  
  const PlanSelectionScreen({
    super.key,
    required this.language,
  });

  @override
  State<PlanSelectionScreen> createState() => _PlanSelectionScreenState();
}

class _PlanSelectionScreenState extends State<PlanSelectionScreen> {
  String? selectedPlan;

  final Map<String, Map<String, String>> _translations = {
    'es': {
      'title': 'Elige tu Plan',
      'subtitle': 'Selecciona el plan que mejor se adapte a tus necesidades',
      'monthly': '/mes',
      'popular': 'Más Popular',
      'selectPlan': 'Seleccionar Plan',
      'continue': 'Continuar',
      'compareFeatures': 'Comparar Características',
      'allPlansInclude': 'Todos los planes incluyen:',
      'feature1': '✓ Seguimiento de pasos básico',
      'feature2': '✓ Metas diarias personalizables',
      'feature3': '✓ Tokens por actividad',
      'feature4': '✓ Soporte 24/7',
    },
    'en': {
      'title': 'Choose Your Plan',
      'subtitle': 'Select the plan that best fits your needs',
      'monthly': '/month',
      'popular': 'Most Popular',
      'selectPlan': 'Select Plan',
      'continue': 'Continue',
      'compareFeatures': 'Compare Features',
      'allPlansInclude': 'All plans include:',
      'feature1': '✓ Basic step tracking',
      'feature2': '✓ Customizable daily goals',
      'feature3': '✓ Tokens for activity',
      'feature4': '✓ 24/7 support',
    },
  };

  String _getText(String key) {
    return _translations[widget.language]?[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final plans = MockDataService.subscriptionPlans;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: const OnboardingProgressIndicator(currentStep: 10, totalSteps: 13),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Text(
                            _getText('title'),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _getText('subtitle'),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF6B7280),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: List.generate(plans.length, (index) {
                          final plan = plans[index];
                          final isSelected = selectedPlan == plan['id'];
                          final isPopular = plan['popular'] == true;
                          
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedPlan = plan['id'];
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: isSelected 
                                          ? Color(plan['color']).withOpacity(0.1)
                                          : Colors.white,
                                      border: Border.all(
                                        color: isSelected 
                                            ? Color(plan['color'])
                                            : Colors.grey.shade300,
                                        width: isSelected ? 2 : 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    plan['name'],
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(plan['color']),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '\$${plan['price'].toStringAsFixed(0)}',
                                                        style: const TextStyle(
                                                          fontSize: 32,
                                                          fontWeight: FontWeight.bold,
                                                          color: Color(0xFF1F2937),
                                                        ),
                                                      ),
                                                      Text(
                                                        _getText('monthly'),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey.shade600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (isSelected)
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Color(plan['color']),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                          ],
                                        ),
                                        
                                        const SizedBox(height: 20),
                                        
                                        // Características
                                        ...List.generate(
                                          (plan['features'] as List).length,
                                          (featureIndex) => Padding(
                                            padding: const EdgeInsets.only(bottom: 8),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.check_circle,
                                                  color: Color(plan['color']),
                                                  size: 20,
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Text(
                                                    plan['features'][featureIndex],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF374151),
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
                                ),
                                
                                // Badge "Más Popular"
                                if (isPopular)
                                  Positioned(
                                    top: -8,
                                    left: 20,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD97706),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        _getText('popular'),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: selectedPlan != null ? () {
                            final selectedPlanData = plans.firstWhere(
                              (plan) => plan['id'] == selectedPlan,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LevelTermsScreen(),
                              ),
                            );
                          } : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6B46C1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            _getText('continue'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}