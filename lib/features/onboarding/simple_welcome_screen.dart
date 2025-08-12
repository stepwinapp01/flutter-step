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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Selector de idioma simple
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => selectedLanguage = 'es'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: selectedLanguage == 'es' ? const Color(0xFF6B46C1) : Colors.transparent,
                        border: Border.all(color: const Color(0xFF6B46C1)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '🇪🇸 ES',
                        style: TextStyle(
                          color: selectedLanguage == 'es' ? Colors.white : const Color(0xFF6B46C1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => setState(() => selectedLanguage = 'en'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: selectedLanguage == 'en' ? const Color(0xFF6B46C1) : Colors.transparent,
                        border: Border.all(color: const Color(0xFF6B46C1)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '🇺🇸 EN',
                        style: TextStyle(
                          color: selectedLanguage == 'en' ? Colors.white : const Color(0xFF6B46C1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
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
              
              const Spacer(),
              
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