import 'package:flutter/material.dart';
import 'phone_registration_screen.dart';
import '../../shared/services/user_service.dart';

class NameRegistrationScreen extends StatefulWidget {
  final String language;
  
  const NameRegistrationScreen({
    super.key,
    required this.language,
  });

  @override
  State<NameRegistrationScreen> createState() => _NameRegistrationScreenState();
}

class _NameRegistrationScreenState extends State<NameRegistrationScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final Map<String, Map<String, String>> _translations = {
    'es': {
      'title': '¿Cómo te llamas?',
      'subtitle': 'Ingresa tu nombre para personalizar tu experiencia',
      'nameHint': 'Tu nombre',
      'continue': 'Continuar',
      'nameRequired': 'El nombre es requerido',
      'nameInvalid': 'Ingresa un nombre válido',
    },
    'en': {
      'title': 'What\'s your name?',
      'subtitle': 'Enter your name to personalize your experience',
      'nameHint': 'Your name',
      'continue': 'Continue',
      'nameRequired': 'Name is required',
      'nameInvalid': 'Enter a valid name',
    },
  };

  String _getText(String key) {
    return _translations[widget.language]?[key] ?? key;
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 
                    MediaQuery.of(context).padding.top - 
                    MediaQuery.of(context).padding.bottom - 
                    kToolbarHeight - 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      
                      // Icono de usuario
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6B46C1).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Color(0xFF6B46C1),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      Text(
                        _getText('title'),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _getText('subtitle'),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Campo de nombre
                      TextFormField(
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: _getText('nameHint'),
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6B46C1)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return _getText('nameRequired');
                          }
                          if (value.trim().length < 2) {
                            return _getText('nameInvalid');
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  
                  // Botón continuar
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _validateAndContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B46C1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
          ),
        ),
      ),
    );
  }

  void _validateAndContinue() {
    if (_formKey.currentState!.validate()) {
      // Guardar el nombre del usuario
      UserService().setUserName(_nameController.text.trim());
      
      // Continuar a la siguiente pantalla
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PhoneRegistrationScreen(language: widget.language),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}