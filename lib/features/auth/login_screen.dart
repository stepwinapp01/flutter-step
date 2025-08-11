import 'package:flutter/material.dart';
import '../onboarding/facial_recognition_screen.dart';

/// Pantalla de login con OAuth Google y datos personales
class LoginScreen extends StatefulWidget {
  final String language;
  
  const LoginScreen({
    super.key,
    required this.language,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _idController = TextEditingController();
  
  bool _isLoading = false;
  bool _acceptTerms = false;

  final Map<String, Map<String, String>> _translations = {
    'es': {
      'title': 'Crear Cuenta',
      'subtitle': 'Completa tu perfil para comenzar',
      'googleLogin': 'Continuar con Google',
      'or': 'o completa manualmente',
      'name': 'Nombre completo',
      'email': 'Correo electrónico',
      'height': 'Altura (cm)',
      'weight': 'Peso (kg)',
      'idNumber': 'Número de documento',
      'acceptTerms': 'Acepto los términos y condiciones',
      'createAccount': 'Crear Cuenta',
      'bmiCalculated': 'IMC calculado: ',
      'nameRequired': 'El nombre es requerido',
      'emailRequired': 'El correo es requerido',
      'emailInvalid': 'Correo inválido',
      'heightRequired': 'La altura es requerida',
      'weightRequired': 'El peso es requerido',
      'idRequired': 'El documento es requerido',
      'termsRequired': 'Debes aceptar los términos',
    },
    'en': {
      'title': 'Create Account',
      'subtitle': 'Complete your profile to get started',
      'googleLogin': 'Continue with Google',
      'or': 'or complete manually',
      'name': 'Full name',
      'email': 'Email address',
      'height': 'Height (cm)',
      'weight': 'Weight (kg)',
      'idNumber': 'ID number',
      'acceptTerms': 'I accept the terms and conditions',
      'createAccount': 'Create Account',
      'bmiCalculated': 'BMI calculated: ',
      'nameRequired': 'Name is required',
      'emailRequired': 'Email is required',
      'emailInvalid': 'Invalid email',
      'heightRequired': 'Height is required',
      'weightRequired': 'Weight is required',
      'idRequired': 'ID is required',
      'termsRequired': 'You must accept the terms',
    },
  };

  String _getText(String key) {
    return _translations[widget.language]?[key] ?? key;
  }

  double? get _bmi {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);
    if (height != null && weight != null && height > 0) {
      return weight / ((height / 100) * (height / 100));
    }
    return null;
  }

  void _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    
    // Simular login con Google
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      // Navegar a reconocimiento facial
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FacialRecognitionScreen(language: widget.language),
        ),
      );
    }
  }

  void _createAccount() async {
    if (!_formKey.currentState!.validate() || !_acceptTerms) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_getText('termsRequired'))),
        );
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });
    
    // Simular creación de cuenta
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      // Navegar a reconocimiento facial
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FacialRecognitionScreen(language: widget.language),
        ),
      );
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
          child: Form(
            key: _formKey,
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
                
                // Botón Google
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: _isLoading ? null : _loginWithGoogle,
                    icon: const Text('G', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    label: Text(_getText('googleLogin')),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Divisor
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _getText('or'),
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // Formulario
                _buildTextField(_nameController, _getText('name'), Icons.person),
                const SizedBox(height: 16),
                _buildTextField(_emailController, _getText('email'), Icons.email, 
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(_heightController, _getText('height'), Icons.height,
                          keyboardType: TextInputType.number),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(_weightController, _getText('weight'), Icons.monitor_weight,
                          keyboardType: TextInputType.number),
                    ),
                  ],
                ),
                
                // Mostrar IMC si está disponible
                if (_bmi != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${_getText('bmiCalculated')}${_bmi!.toStringAsFixed(1)}',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 16),
                _buildTextField(_idController, _getText('idNumber'), Icons.badge),
                
                const SizedBox(height: 24),
                
                // Términos y condiciones
                CheckboxListTile(
                  value: _acceptTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptTerms = value ?? false;
                    });
                  },
                  title: Text(
                    _getText('acceptTerms'),
                    style: const TextStyle(fontSize: 14),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                
                const SizedBox(height: 30),
                
                // Botón crear cuenta
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B46C1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            _getText('createAccount'),
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
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
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
        if (value == null || value.isEmpty) {
          if (label == _getText('name')) return _getText('nameRequired');
          if (label == _getText('email')) return _getText('emailRequired');
          if (label == _getText('height')) return _getText('heightRequired');
          if (label == _getText('weight')) return _getText('weightRequired');
          if (label == _getText('idNumber')) return _getText('idRequired');
        }
        if (label == _getText('email') && value != null && value.isNotEmpty) {
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return _getText('emailInvalid');
          }
        }
        return null;
      },
      onChanged: (value) {
        if (label == _getText('height') || label == _getText('weight')) {
          setState(() {}); // Recalcular IMC
        }
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _idController.dispose();
    super.dispose();
  }
}