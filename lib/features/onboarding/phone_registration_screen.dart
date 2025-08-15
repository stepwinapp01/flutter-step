import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../shared/models/user_model.dart';
import 'age_verification_screen.dart';
import '../../shared/data/countries_data.dart';
import '../../shared/services/user_service.dart';

/// Pantalla de registro de teléfono con verificación SMS
class PhoneRegistrationScreen extends StatefulWidget {
  final String language;
  
  const PhoneRegistrationScreen({
    super.key,
    required this.language,
  });

  @override
  State<PhoneRegistrationScreen> createState() => _PhoneRegistrationScreenState();
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length <= 10) {
      String formatted = '';
      for (int i = 0; i < text.length; i++) {
        if (i == 3 || i == 6) formatted += ' ';
        formatted += text[i];
      }
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
    return oldValue;
  }
}

class _PhoneRegistrationScreenState extends State<PhoneRegistrationScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  String _selectedCountryCode = '+57';
  String _selectedCountryFlag = '🇨🇴';
  bool _showCountryList = false;
  bool _isLoading = false;
  bool _showOtpField = false;
  String? _verificationId;
  String? _selectedGender;

  List<Map<String, String>> _countries = CountriesData.countries;
  List<Map<String, String>> _filteredCountries = CountriesData.countries;
  final _searchController = TextEditingController();

  final Map<String, Map<String, String>> _translations = {
    'es': {
      'title': 'Información Personal',
      'subtitle': 'Ingresa tu nombre y número de teléfono para continuar',
      'fullName': 'Nombre completo',
      'phoneNumber': 'Número de teléfono',
      'otpCode': 'Código de verificación',
      'selectCountry': 'Seleccionar país',
      'gender': 'Sexo',
      'male': 'Hombre',
      'female': 'Mujer',
      'sendCode': 'Continuar',
      'verifyCode': 'Verificar Código',
      'nameRequired': 'El nombre es requerido',
      'phoneRequired': 'El número de teléfono es requerido',
      'phoneInvalid': 'Número de teléfono inválido',
      'otpRequired': 'El código de verificación es requerido',
      'otpSent': 'Código enviado a tu teléfono',
      'verificationFailed': 'Error en la verificación',
    },
    'en': {
      'title': 'Personal Information',
      'subtitle': 'Enter your name and phone number to continue',
      'fullName': 'Full name',
      'phoneNumber': 'Phone number',
      'otpCode': 'Verification code',
      'selectCountry': 'Select country',
      'gender': 'Gender',
      'male': 'Male',
      'female': 'Female',
      'sendCode': 'Continue',
      'verifyCode': 'Verify Code',
      'nameRequired': 'Name is required',
      'phoneRequired': 'Phone number is required',
      'phoneInvalid': 'Invalid phone number',
      'otpRequired': 'Verification code is required',
      'otpSent': 'Code sent to your phone',
      'verificationFailed': 'Verification failed',
    },
  };

  String _getText(String key) {
    return _translations[widget.language]?[key] ?? key;
  }

  @override
  void initState() {
    super.initState();
    _loadGoogleUserData();
  }

  Future<void> _loadGoogleUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.displayName != null) {
      setState(() {
        _nameController.text = currentUser.displayName!;
      });
    }
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
                  prefixIcon: const Icon(HugeIcons.strokeRoundedUser01),
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
              
              // Selector de sexo
              Text(
                _getText('gender'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedGender = 'male'),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedGender == 'male' 
                                ? const Color(0xFF6B46C1) 
                                : Colors.grey.shade300,
                            width: _selectedGender == 'male' ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: _selectedGender == 'male' 
                              ? const Color(0xFF6B46C1).withAlpha(26)
                              : Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedMale01,
                              color: _selectedGender == 'male' 
                                  ? const Color(0xFF6B46C1) 
                                  : Colors.grey.shade600,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _getText('male'),
                              style: TextStyle(
                                color: _selectedGender == 'male' 
                                    ? const Color(0xFF6B46C1) 
                                    : Colors.grey.shade600,
                                fontWeight: _selectedGender == 'male' 
                                    ? FontWeight.w600 
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedGender = 'female'),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedGender == 'female' 
                                ? const Color(0xFF6B46C1) 
                                : Colors.grey.shade300,
                            width: _selectedGender == 'female' ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: _selectedGender == 'female' 
                              ? const Color(0xFF6B46C1).withAlpha(26)
                              : Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedFemale01,
                              color: _selectedGender == 'female' 
                                  ? const Color(0xFF6B46C1) 
                                  : Colors.grey.shade600,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _getText('female'),
                              style: TextStyle(
                                color: _selectedGender == 'female' 
                                    ? const Color(0xFF6B46C1) 
                                    : Colors.grey.shade600,
                                fontWeight: _selectedGender == 'female' 
                                    ? FontWeight.w600 
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        PhoneInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        labelText: _getText('phoneNumber'),
                        hintText: '300 123 4567',
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
              

              
              const SizedBox(height: 40),
              
              // Campo OTP (solo en producción)
              if (_showOtpField && !kDebugMode) ...[
                const SizedBox(height: 20),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: _getText('otpCode'),
                    prefixIcon: const Icon(Icons.sms),
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
              ],
              
              const SizedBox(height: 40),
              
              // Botón de acción
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : (_showOtpField && !kDebugMode ? _verifyOtp : _sendOtp),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          _showOtpField && !kDebugMode ? _getText('verifyCode') : _getText('sendCode'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              
              // Botón de continuar sin código (solo en producción)
              if (_showOtpField && !kDebugMode) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => _saveUserAndContinue(),
                    child: Text(
                      'No recibí el código',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendOtp() async {
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar(_getText('nameRequired'));
      return;
    }

    final phoneDigits = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (_phoneController.text.trim().isNotEmpty && (phoneDigits.length < 7 || phoneDigits.length > 10)) {
      _showSnackBar(_getText('phoneInvalid'));
      return;
    }

    // En desarrollo, omitir SMS
    if (kDebugMode) {
      _showSnackBar('Modo desarrollo: omitiendo SMS...');
      await _saveUserAndContinue();
      return;
    }

    // En producción, intentar SMS
    if (_phoneController.text.trim().isEmpty) {
      await _saveUserAndContinue();
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      final phone = '$_selectedCountryCode$phoneDigits';
      _showSnackBar('Enviando código SMS...');
      
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (credential) => _linkPhoneCredential(credential),
        verificationFailed: (e) {
          setState(() => _isLoading = false);
          if (e.code == 'too-many-requests') {
            _showSnackBar('Demasiadas solicitudes. Continuando...');
          } else {
            _showSnackBar('Error SMS. Continuando...');
          }
          _saveUserAndContinue();
        },
        codeSent: (verificationId, resendToken) {
          setState(() {
            _verificationId = verificationId;
            _showOtpField = true;
            _isLoading = false;
          });
          _showSnackBar(_getText('otpSent'));
        },
        codeAutoRetrievalTimeout: (verificationId) => _verificationId = verificationId,
      );
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error de conexión. Continuando...');
      await _saveUserAndContinue();
    }
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.trim().isEmpty) {
      _showSnackBar(_getText('otpRequired'));
      return;
    }

    // Bypass para testing
    if (_verificationId == 'test_verification_id' && _otpController.text.trim() == '123456') {
      await _saveUserAndContinue();
      return;
    }

    setState(() => _isLoading = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text.trim(),
      );
      await _linkPhoneCredential(credential);
    } catch (e) {
      print('OTP error: $e');
      setState(() => _isLoading = false);
      _showSnackBar('Código incorrecto. Continuando...');
      await _saveUserAndContinue();
    }
  }

  Future<void> _linkPhoneCredential(PhoneAuthCredential credential) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await currentUser.linkWithCredential(credential);
      }
    } catch (e) {
      print('Link credential error: $e');
    }
    await _saveUserAndContinue();
  }

  Future<void> _saveUserAndContinue() async {
    setState(() => _isLoading = true);
    
    try {
      final phoneDigits = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final phone = phoneDigits.isNotEmpty ? '$_selectedCountryCode$phoneDigits' : null;
      
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('Usuario no autenticado');
      }

      final newUser = UserModel(
        uid: currentUser.uid,
        email: currentUser.email ?? '',
        name: _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : 'Usuario',
        phone: phone,
        photoUrl: currentUser.photoURL,
        level: 1,
        plan: 'basic',
        tokenBalance: 0,
        kycVerified: false,
        facialRecognitionDone: false,
        language: widget.language,
        createdAt: DateTime.now(),
        lastActive: DateTime.now(),
        connectedDevices: {},
        hasCompletedOnboarding: false,
        gender: _selectedGender,
      );
      
      await UserService.saveUserProfile(newUser);
      
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AgeVerificationScreen(language: widget.language),
          ),
        );
      }
    } catch (e) {
      print('Error saving user: $e');
      if (mounted) {
        _showSnackBar('Error al guardar datos. Reintentando...');
        // Continuar de todos modos
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AgeVerificationScreen(language: widget.language),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
    _otpController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}