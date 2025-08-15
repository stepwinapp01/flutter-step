import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../main_app/main_tabs_screen.dart';
import '../../shared/services/user_service.dart';

class FaceVerificationScreen extends StatefulWidget {
  const FaceVerificationScreen({super.key});

  @override
  State<FaceVerificationScreen> createState() => _FaceVerificationScreenState();
}

class _FaceVerificationScreenState extends State<FaceVerificationScreen> {
  bool _isScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B46C1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              
              const Text(
                '🔐 Verificación Facial',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Posiciona tu rostro dentro del círculo\npara completar la verificación',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 60),
              
              // Círculo de verificación facial
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isScanning ? Colors.green : Colors.white,
                    width: 4,
                  ),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Center(
                  child: _isScanning
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                              strokeWidth: 3,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Verificando...',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      : Icon(
                          HugeIcons.strokeRoundedFaceRecognition,
                          size: 120,
                          color: Colors.white.withOpacity(0.7),
                        ),
                ),
              ),
              
              const SizedBox(height: 60),
              
              if (!_isScanning)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _startVerification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6B46C1),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Iniciar Verificación',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              const Spacer(),
              
              Text(
                'Tu información biométrica está protegida\ny se procesa de forma segura',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startVerification() {
    setState(() => _isScanning = true);
    
    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        try {
          // Marcar onboarding como completado
          await UserService.markOnboardingComplete();
          
          // Verificar que se guardó correctamente
          final isComplete = await UserService.hasCompletedOnboarding();
          print('Onboarding completed: $isComplete');
          
          if (isComplete) {
            // Navegar al dashboard principal
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MainTabsScreen(),
              ),
              (route) => false,
            );
          } else {
            throw Exception('No se pudo completar el onboarding');
          }
        } catch (e) {
          print('Error completing onboarding: $e');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error al completar el registro. Reintentando...'),
                backgroundColor: Colors.orange,
                action: SnackBarAction(
                  label: 'Continuar',
                  textColor: Colors.white,
                  onPressed: () {
                    // Forzar navegación al dashboard
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainTabsScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            );
            setState(() => _isScanning = false);
          }
        }
      }
    });
  }
}