import 'package:flutter/material.dart';
import '../subscription/subscription_onboarding_screen.dart';
import '../../shared/widgets/primary_button.dart';

class CoachPlanScreen extends StatelessWidget {
  final List<String> medicalConditions;
  
  const CoachPlanScreen({super.key, required this.medicalConditions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Plan Personalizado'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🎯 Plan Generado',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPlanSection('Objetivos Diarios', [
                      '8,000 pasos diarios',
                      '2 litros de agua',
                      '7-8 horas de sueño',
                      '15 min de meditación',
                    ]),
                    const SizedBox(height: 20),
                    _buildPlanSection('Rutina de Ejercicios', [
                      'Lunes: Caminata 30 min',
                      'Miércoles: Ejercicios básicos',
                      'Viernes: Actividad libre',
                      'Domingo: Descanso activo',
                    ]),
                    const SizedBox(height: 20),
                    if (medicalConditions.isNotEmpty)
                      _buildPlanSection('Consideraciones Médicas', 
                        medicalConditions.map((c) => 'Adaptado para: $c').toList()),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              text: 'Continuar',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SubscriptionOnboardingScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPlanSection(String title, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text(item)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}