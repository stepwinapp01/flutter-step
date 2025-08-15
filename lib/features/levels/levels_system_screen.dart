import 'package:flutter/material.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';
import '../payment/plan_selection_screen.dart';

class LevelsSystemScreen extends StatefulWidget {
  final bool isOnboarding;
  
  const LevelsSystemScreen({
    super.key,
    this.isOnboarding = false,
  });

  @override
  State<LevelsSystemScreen> createState() => _LevelsSystemScreenState();
}

class _LevelsSystemScreenState extends State<LevelsSystemScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _levels = [
    {
      'level': 1,
      'name': 'Despertar',
      'description': 'Primeros pasos en tu viaje de transformación',
      'color': const Color(0xFF10B981),
      'icon': Icons.wb_sunny,
      'requirements': '1,000 pasos diarios',
      'rewards': '10 tokens por día',
    },
    {
      'level': 2,
      'name': 'Explorar',
      'description': 'Descubre nuevas posibilidades',
      'color': const Color(0xFF3B82F6),
      'icon': Icons.explore,
      'requirements': '3,000 pasos diarios',
      'rewards': '25 tokens por día',
    },
    {
      'level': 3,
      'name': 'Construir',
      'description': 'Forma hábitos sólidos y duraderos',
      'color': const Color(0xFF8B5CF6),
      'icon': Icons.build,
      'requirements': '5,000 pasos diarios',
      'rewards': '50 tokens por día',
    },
    {
      'level': 4,
      'name': 'Florecer',
      'description': 'Tu crecimiento se hace visible',
      'color': const Color(0xFFEC4899),
      'icon': Icons.local_florist,
      'requirements': '7,500 pasos diarios',
      'rewards': '75 tokens por día',
    },
    {
      'level': 5,
      'name': 'Brillar',
      'description': 'Alcanza la excelencia en tus hábitos',
      'color': const Color(0xFFF59E0B),
      'icon': Icons.star,
      'requirements': '10,000 pasos diarios',
      'rewards': '100 tokens por día',
    },
    {
      'level': 6,
      'name': 'Trascender',
      'description': 'Supera tus propios límites',
      'color': const Color(0xFF6366F1),
      'icon': Icons.trending_up,
      'requirements': '12,500 pasos diarios',
      'rewards': '150 tokens por día',
    },
    {
      'level': 7,
      'name': 'Leyenda',
      'description': 'Únete a la élite de Step Win',
      'color': const Color(0xFFDC2626),
      'icon': Icons.emoji_events,
      'requirements': '15,000 pasos diarios',
      'rewards': '200 tokens por día',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            if (widget.isOnboarding) ...[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: const OnboardingProgressIndicator(currentStep: 9, totalSteps: 13),
              ),
            ] else ...[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  'Sistema de Niveles',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sistema de Niveles',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Progresa a través de 10 niveles únicos y desbloquea recompensas increíbles',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _levels.length,
                itemBuilder: (context, index) {
                  final level = _levels[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: level['color'].withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: level['color'],
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            level['icon'],
                            size: 60,
                            color: level['color'],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Nivel ${level['level']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: level['color'],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          level['name'],
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          level['description'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6B7280),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
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
                                  Icon(
                                    Icons.flag,
                                    color: level['color'],
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Requisito:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF374151),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    level['requirements'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on,
                                    color: level['color'],
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Recompensa:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF374151),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    level['rewards'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _levels.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? const Color(0xFF6B46C1)
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (widget.isOnboarding) ...[
                    Row(
                      children: [
                        if (_currentPage > 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Anterior'),
                            ),
                          ),
                        if (_currentPage > 0) const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _currentPage == _levels.length - 1
                                ? _continue
                                : () => _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6B46C1),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              _currentPage == _levels.length - 1
                                  ? 'Continuar'
                                  : 'Siguiente',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B46C1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Entendido',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ],
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
        builder: (context) => const PlanSelectionScreen(language: 'es'),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}