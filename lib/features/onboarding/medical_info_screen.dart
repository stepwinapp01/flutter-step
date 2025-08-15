import 'package:flutter/material.dart';
import '../../shared/models/user_model.dart';
import 'coach_plan_screen.dart';
import '../../shared/services/user_service.dart';

class MedicalInfoScreen extends StatefulWidget {
  const MedicalInfoScreen({super.key});

  @override
  State<MedicalInfoScreen> createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends State<MedicalInfoScreen> {
  final List<String> _selectedConditions = [];
  
  final List<Map<String, dynamic>> _medicalConditions = [
    {'name': 'Diabetes', 'icon': '🩺'},
    {'name': 'Hipertensión', 'icon': '💓'},
    {'name': 'Problemas cardíacos', 'icon': '❤️'},
    {'name': 'Asma', 'icon': '🫁'},
    {'name': 'Artritis', 'icon': '🦴'},
    {'name': 'Problemas de espalda', 'icon': '🏥'},
    {'name': 'Lesiones previas', 'icon': '🩹'},
    {'name': 'Embarazo', 'icon': '🤱'},
    {'name': 'Ninguna', 'icon': '✅'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🏥 Información Médica',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            
            Text(
              'Selecciona cualquier condición médica que tengas para personalizar tu plan de ejercicios',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
            
            const SizedBox(height: 32),
            
            Expanded(
              child: ListView.builder(
                itemCount: _medicalConditions.length,
                itemBuilder: (context, index) {
                  final condition = _medicalConditions[index];
                  final isSelected = _selectedConditions.contains(condition['name']);
                  
                  return GestureDetector(
                    onTap: () => _toggleCondition(condition['name']),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? const Color(0xFF6B46C1).withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected 
                              ? const Color(0xFF6B46C1)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            condition['icon'],
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 16),
                          
                          Expanded(
                            child: Text(
                              condition['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelected 
                                    ? const Color(0xFF6B46C1)
                                    : Colors.black,
                              ),
                            ),
                          ),
                          
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF6B46C1),
                            ),
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
                onPressed: _selectedConditions.isNotEmpty ? _continueToCoachPlan : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: const Text(
                  'Continuar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleCondition(String condition) {
    setState(() {
      if (condition == 'Ninguna') {
        _selectedConditions.clear();
        _selectedConditions.add(condition);
      } else {
        _selectedConditions.remove('Ninguna');
        if (_selectedConditions.contains(condition)) {
          _selectedConditions.remove(condition);
        } else {
          _selectedConditions.add(condition);
        }
      }
    });
  }

  void _continueToCoachPlan() {
    _saveMedicalConditionsAndContinue();
  }

  Future<void> _saveMedicalConditionsAndContinue() async {
    final user = await UserService.getUserProfile();
    if (user != null) {
      final updatedUser = user.copyWith(medicalConditions: _selectedConditions);
      await UserService.saveUserProfile(updatedUser);
    }

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoachPlanScreen(
            medicalConditions: _selectedConditions,
          ),
        ),
      );
    }
  }
}