import 'package:flutter/material.dart';
import 'age_verification_screen.dart';
import '../../shared/data/countries_data.dart';
import '../../shared/services/user_service.dart';

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
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedCountryCode = '+57';
  String _selectedCountryFlag = '🇨🇴';
  bool _showCountryList = false;

  List<Map<String, String>> _countries = CountriesData.countries;
  List<Map<String, String>> _filteredCountries = CountriesData.countries;
  final _searchController = TextEditingController();

  final Map<String, Map<String, String>> _translations = {
    'es': {
      'title': 'Información Personal',
      'subtitle': 'Ingresa tu nombre y número de teléfono para continuar',
      'fullName': 'Nombre completo',
      'phoneNumber': 'Número de teléfono',
      'selectCountry': 'Seleccionar país',
      'continue': 'Continuar',
      'nameRequired': 'El nombre es requerido',
      'phoneRequired': 'El número de teléfono es requerido',
      'phoneInvalid': 'Número de teléfono inválido',
    },
    'en': {
      'title': 'Personal Information',
      'subtitle': 'Enter your name and phone number to continue',
      'fullName': 'Full name',
      'phoneNumber': 'Phone number',
      'selectCountry': 'Select country',
      'continue': 'Continue',
      'nameRequired': 'Name is required',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
              
              // Campo de nombre completo
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: _getText('fullName'),
                  prefixIcon: const Icon(Icons.person),
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
              
              const SizedBox(height: 20),
              
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
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // Buscador
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Buscar país...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          onChanged: _filterCountries,
                        ),
                      ),
                      // Lista de países
                      Expanded(
                        child: ListView.builder(
                          itemCount: _filteredCountries.length,
                          itemBuilder: (context, index) {
                            final country = _filteredCountries[index];
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
                                  _searchController.clear();
                                  _filteredCountries = _countries;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              
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
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _validateAndContinue() {
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar(_getText('nameRequired'));
      return;
    }

    if (_phoneController.text.trim().isEmpty) {
      _showSnackBar(_getText('phoneRequired'));
      return;
    }

    if (_phoneController.text.trim().length < 7) {
      _showSnackBar(_getText('phoneInvalid'));
      return;
    }

    // Guardar el nombre del usuario
    UserService().setUserName(_nameController.text.trim());

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

  void _filterCountries(String query) {
    setState(() {
      _filteredCountries = CountriesData.searchCountries(query);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}