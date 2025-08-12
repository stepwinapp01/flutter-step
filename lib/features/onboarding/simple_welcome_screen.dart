import 'package:flutter/material.dart';
import '../subscription/subscription_onboarding_screen.dart';

/// Pantalla de bienvenida ultra simple sin DropdownButton
class SimpleWelcomeScreen extends StatefulWidget {
  const SimpleWelcomeScreen({super.key});

  @override
  State<SimpleWelcomeScreen> createState() => _SimpleWelcomeScreenState();
}

class _SimpleWelcomeScreenState extends State<SimpleWelcomeScreen> {
  String selectedLanguage = 'es';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Selector de idioma desplegable
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedLanguage,
                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF6B46C1)),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() => selectedLanguage = newValue);
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'es',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('🇪🇸', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 8),
                              Text('ES', style: TextStyle(color: Color(0xFF6B46C1), fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('🇺🇸', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 8),
                              Text('EN', style: TextStyle(color: Color(0xFF6B46C1), fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 60),
              
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B46C1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'SWT',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Título
              Text(
                selectedLanguage == 'es' ? '¡Bienvenido a Step Win!' : 'Welcome to Step Win!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 10),
              
              Text(
                selectedLanguage == 'es' 
                    ? 'Transforma tus pasos en recompensas reales'
                    : 'Transform your steps into real rewards',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Características
              Column(
                children: [
                  _buildFeature('🚶', selectedLanguage == 'es' ? 'Gana tokens por cada paso' : 'Earn tokens for every step'),
                  _buildFeature('💰', selectedLanguage == 'es' ? 'Retira dinero real (USDT/USDC)' : 'Withdraw real money (USDT/USDC)'),
                  _buildFeature('🤖', selectedLanguage == 'es' ? 'Coach IA personalizado' : 'Personalized AI Coach'),
                  _buildFeature('👥', selectedLanguage == 'es' ? 'Comunidad motivadora' : 'Motivating community'),
                ],
              ),
              
              const SizedBox(height: 60),
              
              // Botón continuar
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SubscriptionOnboardingScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    selectedLanguage == 'es' ? 'Continuar' : 'Continue',
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

  Widget _buildFeature(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Color(0xFF374151)),
            ),
          ),
        ],
      ),
    );
  }
}