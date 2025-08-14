import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../onboarding/simple_welcome_screen.dart';
import 'auth_service.dart';
import 'otp_verification_screen.dart';

class SMSAuthScreen extends StatefulWidget {
  const SMSAuthScreen({super.key});

  @override
  State<SMSAuthScreen> createState() => _SMSAuthScreenState();
}

class _SMSAuthScreenState extends State<SMSAuthScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  String? _verificationId;
  bool _codeSent = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B46C1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'STW',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B46C1),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              Text(
                _codeSent ? 'Verificar SMS' : 'Ingresa tu teléfono',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Text(
                _codeSent 
                  ? 'Ingresa el código de 6 dígitos enviado a tu teléfono'
                  : 'Te enviaremos un código de verificación',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              if (!_codeSent) ...[
                // Campo teléfono
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: '+1234567890',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ] else ...[
                // Campo código
                TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: const TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 8),
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: '000000',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    counterText: '',
                  ),
                ),
              ],
              
              const SizedBox(height: 24),
              
              // Botón principal
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : (_codeSent ? _verifyCode : _sendCode),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6B46C1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _loading
                    ? const CircularProgressIndicator(color: Color(0xFF6B46C1))
                    : Text(
                        _codeSent ? 'Verificar código' : 'Enviar código',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ),
              ),
              
              if (_codeSent) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _loading ? null : _resendCode,
                  child: Text(
                    'Reenviar código',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
              
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _sendCode() async {
    if (_phoneController.text.trim().isEmpty) {
      _showError('Ingresa tu número de teléfono');
      return;
    }

    setState(() => _loading = true);

    try {
      await AuthService.verifyPhoneNumber(
        phoneNumber: _phoneController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verificación completada
          final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          if (mounted && userCredential.user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SimpleWelcomeScreen()),
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (mounted) {
            setState(() => _loading = false);
            if (e.code == 'operation-not-allowed') {
              _showError('La autenticación por teléfono no está habilitada. Revisa Firebase Console.');
            } else {
              _showError('Error: ${e.message}');
            }
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          if (mounted) {
            setState(() => _loading = false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OtpVerificationScreen(verificationId: verificationId),
              ),
            );
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        _showError('Error de conexión: $e');
      }
    }
  }

  void _verifyCode() async {
    if (_codeController.text.trim().length != 6) {
      _showError('Ingresa el código de 6 dígitos');
      return;
    }

    setState(() => _loading = true);

    try {
      final result = await AuthService.verifySMSCode(
        _verificationId!,
        _codeController.text.trim(),
      );
      
      if (mounted) {
        setState(() => _loading = false);
        
        if (result['success'] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SimpleWelcomeScreen(),
            ),
          );
        } else {
          _showError('Código incorrecto');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        _showError('Error al verificar código');
      }
    }
  }

  void _resendCode() {
    setState(() {
      _codeSent = false;
      _codeController.clear();
    });
    _sendCode();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }
}