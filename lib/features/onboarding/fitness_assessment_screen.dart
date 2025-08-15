import 'package:flutter/material.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/models/fitness_profile_model.dart';
import '../../shared/services/coach_ai_service.dart';
import 'current_habits_screen.dart';

/// Pantalla de evaluación física inicial
class FitnessAssessmentScreen extends StatefulWidget {
  final int? age;
  
  const FitnessAssessmentScreen({super.key, this.age});

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
  
  @override
  void initState() {
    super.initState();
    // Pre-llenar la edad si viene de la pantalla anterior
    if (widget.age != null) {
      _ageController.text = widget.age.toString();
    }
    
    // Agregar listeners para actualizar el estado
    _weightController.addListener(() => setState(() {}));
    _heightController.addListener(() => setState(() {}));
    _ageController.addListener(() => setState(() {}));
  }
  String _activityLevel = 'sedentary';


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

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: const OnboardingProgressIndicator(currentStep: 4, totalSteps: 13),
            ),
          
          // Contenido de las páginas
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: [
                _buildBasicInfoPage(),
                _buildActivityLevelPage(),
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
                    onPressed: _canContinue() ? (_currentPage == 1 ? _generatePlan : () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    )) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      _currentPage == 1 ? 'Continuar' : 'Siguiente',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
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
            readOnly: widget.age != null,
            decoration: InputDecoration(
              labelText: 'Edad (años)',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.cake),
              suffixIcon: widget.age != null 
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : null,
              filled: widget.age != null,
              fillColor: widget.age != null ? Colors.grey.shade100 : null,
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





  bool _canContinue() {
    if (_currentPage == 0) {
      return _weightController.text.isNotEmpty && 
             _heightController.text.isNotEmpty && 
             _ageController.text.isNotEmpty;
    }
    return true; // Página 1 siempre puede continuar
  }

  void _generatePlan() {

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
        screenTimeHours: 8,
        currentWaterGlasses: 6,
        currentSleepHours: 6.0,
        currentWalkingMinutes: 15,
        currentMeditationMinutes: 0,
        healthConditions: [],
        createdAt: DateTime.now(),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CurrentHabitsScreen(),
        ),
      );
    });
  }
}