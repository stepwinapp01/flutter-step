import 'package:flutter/material.dart';
import 'age_verification_screen.dart';

/// Pantalla de registro de teléfono con selector de código de país
class PhoneRegistrationScreen extends StatefulWidget {
  final String language;
  
  const PhoneRegistrationScreen({
    super.key,
    required this.language,
  });

  @override
  State<PhoneRegistrationScreen> createState() => _PhoneRegistrationScreenState();
}

class _PhoneRegistrationScreenState extends State<PhoneRegistrationScreen> {
  final _phoneController = TextEditingController();
  String _selectedCountryCode = '+57';
  String _selectedCountryFlag = '🇨🇴';
  bool _showCountryList = false;

  // Lista de países con códigos únicos
  final List<Map<String, String>> _countries = [
    {'name': 'Colombia', 'code': '+57', 'flag': '🇨🇴'},
    {'name': 'Estados Unidos', 'code': '+1', 'flag': '🇺🇸'},
    {'name': 'México', 'code': '+52', 'flag': '🇲🇽'},
    {'name': 'España', 'code': '+34', 'flag': '🇪🇸'},
    {'name': 'Argentina', 'code': '+54', 'flag': '🇦🇷'},
    {'name': 'Chile', 'code': '+56', 'flag': '🇨🇱'},
    {'name': 'Perú', 'code': '+51', 'flag': '🇵🇪'},
    {'name': 'Venezuela', 'code': '+58', 'flag': '🇻🇪'},
    {'name': 'Ecuador', 'code': '+593', 'flag': '🇪🇨'},
    {'name': 'Brasil', 'code': '+55', 'flag': '🇧🇷'},
    {'name': 'Canadá', 'code': '+1-CA', 'flag': '🇨🇦'},
    {'name': 'Reino Unido', 'code': '+44', 'flag': '🇬🇧'},
    {'name': 'Francia', 'code': '+33', 'flag': '🇫🇷'},
    {'name': 'Alemania', 'code': '+49', 'flag': '🇩🇪'},
    {'name': 'Italia', 'code': '+39', 'flag': '🇮🇹'},
  ];

  final Map<String, Map<String, String>> _translations = {
    'es': {
      'title': 'Número de Teléfono',
      'subtitle': 'Ingresa tu número de teléfono para continuar',
      'phoneNumber': 'Número de teléfono',
      'selectCountry': 'Seleccionar país',
      'continue': 'Continuar',
      'phoneRequired': 'El número de teléfono es requerido',
      'phoneInvalid': 'Número de teléfono inválido',
    },
    'en': {
      'title': 'Phone Number',
      'subtitle': 'Enter your phone number to continue',
      'phoneNumber': 'Phone number',
      'selectCountry': 'Select country',
      'continue': 'Continue',
      'phoneRequired': 'Phone number is required',
      'phoneInvalid': 'Invalid phone number',
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
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Selector de país y número de teléfono
              Row(
                children: [
                  // Selector de país
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showCountryList = !_showCountryList;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_selectedCountryFlag, style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 8),
                          Text(
                            _selectedCountryCode,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            _showCountryList ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Campo de número de teléfono
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: _getText('phoneNumber'),
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
                    ),
                  ),
                ],
              ),
              
              // Lista de países (cuando está expandida)
              if (_showCountryList) ...[
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    itemCount: _countries.length,
                    itemBuilder: (context, index) {
                      final country = _countries[index];
                      return ListTile(
                        leading: Text(country['flag']!, style: const TextStyle(fontSize: 20)),
                        title: Text(country['name']!),
                        trailing: Text(
                          country['code']!,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedCountryCode = country['code']!;
                            _selectedCountryFlag = country['flag']!;
                            _showCountryList = false;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
              
              const Spacer(),
              
              // Botón continuar
              SizedBox(
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
            ],
          ),
        ),
      ),
    );
  }

  void _validateAndContinue() {
    if (_phoneController.text.trim().isEmpty) {
      _showSnackBar(_getText('phoneRequired'));
      return;
    }

    if (_phoneController.text.trim().length < 7) {
      _showSnackBar(_getText('phoneInvalid'));
      return;
    }

    // Continuar a la siguiente pantalla
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AgeVerificationScreen(language: widget.language),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF6B46C1),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}