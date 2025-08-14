import 'package:flutter/material.dart';
import 'onboarding_flow.dart';

/// Pantalla de verificación de edad (16+ años requerido)
class AgeVerificationScreen extends StatefulWidget {
  final String language;
  
  const AgeVerificationScreen({
    super.key,
    required this.language,
  });

  @override
  State<AgeVerificationScreen> createState() => _AgeVerificationScreenState();
}

class _AgeVerificationScreenState extends State<AgeVerificationScreen> {
  DateTime? selectedDate;
  bool showParentalConsent = false;
  bool parentalConsentGiven = false;

  final Map<String, Map<String, String>> _translations = {
    'es': {
      'title': 'Verificación de Edad',
      'subtitle': 'Para usar Step Win, debes tener al menos 16 años',
      'birthDate': 'Fecha de nacimiento',
      'selectDate': 'Seleccionar fecha',
      'under16': 'Lo sentimos, debes tener al menos 16 años para usar Step Win.',
      'minor16-17': 'Como eres menor de 18 años, necesitas autorización parental.',
      'parentalConsent': 'Autorización Parental Requerida',
      'parentalText': 'Un padre o tutor debe autorizar tu uso de la aplicación.',
      'iAmParent': 'Soy el padre/tutor y autorizo el uso',
      'continue': 'Continuar',
      'ageValid': '¡Perfecto! Puedes usar Step Win.',
    },
    'en': {
      'title': 'Age Verification',
      'subtitle': 'To use Step Win, you must be at least 16 years old',
      'birthDate': 'Date of birth',
      'selectDate': 'Select date',
      'under16': 'Sorry, you must be at least 16 years old to use Step Win.',
      'minor16-17': 'As you are under 18, you need parental authorization.',
      'parentalConsent': 'Parental Authorization Required',
      'parentalText': 'A parent or guardian must authorize your use of the app.',
      'iAmParent': 'I am the parent/guardian and authorize use',
      'continue': 'Continue',
      'ageValid': 'Perfect! You can use Step Win.',
    },
  };

  String _getText(String key) {
    return _translations[widget.language]?[key] ?? key;
  }

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
      lastDate: DateTime.now(),
      locale: Locale(widget.language),
    );
    
    if (date != null) {
      setState(() {
        selectedDate = date;
        final age = _calculateAge(date);
        showParentalConsent = age >= 16 && age < 18;
        parentalConsentGiven = false;
      });
    }
  }

  bool get canContinue {
    if (selectedDate == null) return false;
    final age = _calculateAge(selectedDate!);
    if (age < 16) return false;
    if (age >= 18) return true;
    return parentalConsentGiven;
  }

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getText('title'),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _getText('subtitle'),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Selector de fecha
              Text(
                _getText('birthDate'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _selectDate,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.grey.shade600),
                      const SizedBox(width: 12),
                      Text(
                        selectedDate != null
                            ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                            : _getText('selectDate'),
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedDate != null 
                              ? Colors.black 
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Validación de edad
              if (selectedDate != null) ...[
                _buildAgeValidation(),
              ],
              
              const Spacer(),
              
              // Botón continuar
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: canContinue ? () {
                    final age = _calculateAge(selectedDate!);
                    OnboardingFlow.goToFitnessAssessment(context, age);
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgeValidation() {
    final age = _calculateAge(selectedDate!);
    
    if (age < 16) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.error, color: Colors.red.shade600),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _getText('under16'),
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    if (age >= 16 && age < 18) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange.shade600),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _getText('minor16-17'),
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _getText('parentalConsent'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getText('parentalText'),
                  style: TextStyle(
                    color: Colors.orange.shade700,
                  ),
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  value: parentalConsentGiven,
                  onChanged: (value) {
                    setState(() {
                      parentalConsentGiven = value ?? false;
                    });
                  },
                  title: Text(
                    _getText('iAmParent'),
                    style: const TextStyle(fontSize: 14),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      );
    }
    
    // Edad válida (18+)
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _getText('ageValid'),
              style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}