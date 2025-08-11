import 'package:flutter/material.dart';
import '../subscription/subscription_plans_screen.dart';

class CoachPlanScreen extends StatefulWidget {
  final List<String> medicalConditions;
  
  const CoachPlanScreen({
    super.key,
    required this.medicalConditions,
  });

  @override
  State<CoachPlanScreen> createState() => _CoachPlanScreenState();
}

class _CoachPlanScreenState extends State<CoachPlanScreen> {
  bool _planAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B46C1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Header del Coach
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Text(
                        '🤖',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Coach Adán',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'He creado un plan personalizado para ti',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Plan personalizado
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🎯 Tu Plan Personalizado',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    _buildPlanGoal(
                      '🚶',
                      'Pasos Diarios',
                      '8,000 pasos',
                      'Meta base para mantener actividad',
                    ),
                    
                    _buildPlanGoal(
                      '⏱️',
                      'Actividad Moderada',
                      '30 minutos',
                      'Ejercicio cardiovascular ligero',
                    ),
                    
                    _buildPlanGoal(
                      '💧',
                      'Hidratación',
                      '2 litros',
                      'Mantén tu cuerpo hidratado',
                    ),
                    
                    _buildPlanGoal(
                      '😴',
                      'Descanso',
                      '7-8 horas',
                      'Sueño reparador esencial',
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Racha semanal
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6B46C1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '🔥 Racha Semanal',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B46C1),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Completa tus metas diarias para mantener tu racha y ganar tokens extra',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          
                          // Indicadores de días de la semana
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: ['L', 'M', 'X', 'J', 'V', 'S', 'D'].map((day) {
                              return Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    day,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    
                    if (widget.medicalConditions.isNotEmpty && !widget.medicalConditions.contains('Ninguna'))
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.orange.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '⚠️ Consideraciones Médicas',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'He adaptado tu plan considerando: ${widget.medicalConditions.join(', ')}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.orange.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Checkbox de aceptación
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CheckboxListTile(
                  value: _planAccepted,
                  onChanged: (value) => setState(() => _planAccepted = value ?? false),
                  title: const Text(
                    'Acepto este plan personalizado y me comprometo a seguirlo',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  activeColor: Colors.white,
                  checkColor: const Color(0xFF6B46C1),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Botón continuar
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _planAccepted ? _continueToLevels : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6B46C1),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: Colors.white.withOpacity(0.3),
                    ),
                    child: const Center(
                      child: Text(
                        'Comenzar mi Transformación',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanGoal(String icon, String title, String target, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF6B46C1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(height: 12),
          
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          
          Text(
            target,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B46C1),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _continueToLevels() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SubscriptionPlansScreen(),
      ),
    );
  }
}