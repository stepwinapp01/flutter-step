import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/models/fitness_profile_model.dart';
import '../../shared/services/coach_ai_service.dart';
import '../coach/presentation/coach_plan_screen.dart';

/// Pantalla de evaluación física inicial
class FitnessAssessmentScreen extends StatefulWidget {
  const FitnessAssessmentScreen({super.key});

  @override
  State<FitnessAssessmentScreen> createState() => _FitnessAssessmentScreenState();
}

class _FitnessAssessmentScreenState extends State<FitnessAssessmentScreen> {
  final _pageController = PageController();
  int _currentPage = 0;
  
  // Datos del formulario
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  String _activityLevel = 'sedentary';
  int _screenTimeHours = 8;
  double _currentWaterIntake = 1.5;
  double _currentSleepHours = 6.0;
  int _currentDailySteps = 3000;
  final List<String> _healthConditions = [];

  @override
  void dispose() {
    _pageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Evaluación Física'),
        backgroundColor: AppConstants.primaryPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Indicador de progreso
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
                    decoration: BoxDecoration(
                      color: index <= _currentPage 
                          ? AppConstants.primaryPurple 
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          // Contenido de las páginas
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: [
                _buildBasicInfoPage(),
                _buildActivityLevelPage(),
                _buildHabitsPage(),
                _buildHealthConditionsPage(),
              ],
            ),
          ),
          
          // Botones de navegación
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentPage > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: const Text('Anterior'),
                    ),
                  ),
                if (_currentPage > 0) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentPage == 3 ? _generatePlan : () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      _currentPage == 3 ? 'Generar Mi Plan' : 'Siguiente',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 Información Básica',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Necesito conocer algunos datos básicos para crear tu plan personalizado.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 32),
          
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Peso (kg)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.monitor_weight),
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Altura (cm)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.height),
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Edad (años)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.cake),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityLevelPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🏃 Nivel de Actividad',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '¿Cómo describirías tu nivel de actividad física actual?',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 32),
          
          ...[
            ('sedentary', '🛋️ Sedentario', 'Poco o nada de ejercicio, trabajo de oficina'),
            ('light', '🚶 Ligero', 'Ejercicio ligero 1-3 días por semana'),
            ('moderate', '🏃 Moderado', 'Ejercicio moderado 3-5 días por semana'),
            ('active', '💪 Activo', 'Ejercicio intenso 6-7 días por semana'),
          ].map((option) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: RadioListTile<String>(
              value: option.$1,
              groupValue: _activityLevel,
              onChanged: (value) => setState(() => _activityLevel = value!),
              title: Text(option.$2, style: const TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(option.$3),
              activeColor: AppConstants.primaryPurple,
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildHabitsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '⏰ Hábitos Actuales',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Cuéntame sobre tus hábitos diarios actuales.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 32),
          
          Text('📱 Tiempo de pantalla diario: ${_screenTimeHours}h'),
          Slider(
            value: _screenTimeHours.toDouble(),
            min: 2,
            max: 16,
            divisions: 14,
            onChanged: (value) => setState(() => _screenTimeHours = value.round()),
            activeColor: AppConstants.primaryPurple,
          ),
          const SizedBox(height: 24),
          
          Text('💧 Consumo de agua actual: ${_currentWaterIntake.toStringAsFixed(1)}L'),
          Slider(
            value: _currentWaterIntake,
            min: 0.5,
            max: 4.0,
            divisions: 14,
            onChanged: (value) => setState(() => _currentWaterIntake = value),
            activeColor: AppConstants.primaryPurple,
          ),
          const SizedBox(height: 24),
          
          Text('😴 Horas de sueño actuales: ${_currentSleepHours.toStringAsFixed(1)}h'),
          Slider(
            value: _currentSleepHours,
            min: 4.0,
            max: 12.0,
            divisions: 16,
            onChanged: (value) => setState(() => _currentSleepHours = value),
            activeColor: AppConstants.primaryPurple,
          ),
          const SizedBox(height: 24),
          
          Text('🚶 Pasos diarios aproximados: $_currentDailySteps'),
          Slider(
            value: _currentDailySteps.toDouble(),
            min: 1000,
            max: 15000,
            divisions: 14,
            onChanged: (value) => setState(() => _currentDailySteps = value.round()),
            activeColor: AppConstants.primaryPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildHealthConditionsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🏥 Condiciones de Salud',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Selecciona cualquier condición que tengas (opcional).',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 32),
          
          ...[
            'Diabetes',
            'Hipertensión',
            'Problemas cardíacos',
            'Problemas articulares',
            'Asma',
            'Lesiones previas',
            'Ninguna',
          ].map((condition) => CheckboxListTile(
            value: _healthConditions.contains(condition),
            onChanged: (checked) {
              setState(() {
                if (condition == 'Ninguna') {
                  _healthConditions.clear();
                  if (checked!) _healthConditions.add(condition);
                } else {
                  _healthConditions.remove('Ninguna');
                  if (checked!) {
                    _healthConditions.add(condition);
                  } else {
                    _healthConditions.remove(condition);
                  }
                }
              });
            },
            title: Text(condition),
            activeColor: AppConstants.primaryPurple,
          )).toList(),
        ],
      ),
    );
  }

  void _generatePlan() {
    if (_weightController.text.isEmpty || _heightController.text.isEmpty || _ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa la información básica')),
      );
      return;
    }

    // Mostrar loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simular generación de plan
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Cerrar loading
      
      final profile = FitnessProfileModel(
        userId: 'user_123',
        weight: double.parse(_weightController.text),
        height: double.parse(_heightController.text),
        age: int.parse(_ageController.text),
        activityLevel: _activityLevel,
        screenTimeHours: _screenTimeHours,
        currentWaterIntake: _currentWaterIntake,
        currentSleepHours: _currentSleepHours,
        currentDailySteps: _currentDailySteps,
        healthConditions: _healthConditions,
        createdAt: DateTime.now(),
      );

      final plan = FitnessPlanGenerator.generatePersonalizedPlan(profile);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CoachPlanScreen(plan: plan),
        ),
      );
    });
  }
}