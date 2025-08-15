import 'package:flutter/material.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';
import 'device_connection_screen.dart';

/// Pantalla simple de términos y niveles
class LevelTermsScreen extends StatelessWidget {
  const LevelTermsScreen({super.key});
  
  Widget _buildLevelCard(String icon, String title, String tokens, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6B46C1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF6B46C1).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B46C1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tokens,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgressIndicator(currentStep: 11, totalSteps: 13),
              const SizedBox(height: 32),
              const Text(
                'Términos y Condiciones',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Revisa y acepta nuestros términos para continuar',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                ),
              ),
            const SizedBox(height: 20),
            
            // Sistema de 10 niveles
            _buildLevelCard('☀️', 'Nivel 1: Despertar', '1,000 pasos diarios', '10 tokens por día'),
            const SizedBox(height: 8),
            _buildLevelCard('🗺️', 'Nivel 2: Explorar', '3,000 pasos diarios', '25 tokens por día'),
            const SizedBox(height: 8),
            _buildLevelCard('🔨', 'Nivel 3: Construir', '5,000 pasos diarios', '50 tokens por día'),
            const SizedBox(height: 8),
            _buildLevelCard('🌸', 'Nivel 4: Florecer', '7,500 pasos diarios', '75 tokens por día'),
            const SizedBox(height: 8),
            _buildLevelCard('⭐', 'Nivel 5: Brillar', '10,000 pasos diarios', '100 tokens por día'),
            const SizedBox(height: 8),
            _buildLevelCard('📈', 'Nivel 6: Trascender', '12,500 pasos diarios', '150 tokens por día'),
            const SizedBox(height: 8),
            _buildLevelCard('🏆', 'Nivel 7: Leyenda', '15,000 pasos diarios', '200 tokens por día'),
            const SizedBox(height: 8),
            _buildLevelCard('🎓', 'Nivel 8: Maestro', '17,500 pasos diarios', '250 tokens por día'),
            const SizedBox(height: 8),
            _buildLevelCard('🏋️', 'Nivel 9: Titan', '20,000 pasos diarios', '300 tokens por día'),
            const SizedBox(height: 8),
            _buildLevelCard('🎖️', 'Nivel 10: Inmortal', '25,000 pasos diarios', '500 tokens por día'),
            
            const SizedBox(height: 30),
            const Text(
              'Términos de Uso',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
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
                      Icon(Icons.medical_services, color: Colors.orange.shade600, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Aviso Médico Importante',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '• El Coach Adán sigue recomendaciones de la OMS\n\n• Su uso NO debe reemplazar consultas médicas\n\n• El usuario es responsable de cuidar su salud\n\n• Consulte a su médico antes de iniciar ejercicios',
                    style: TextStyle(fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Al usar Step Win aceptas nuestros términos de servicio y política de privacidad.',
                style: TextStyle(fontSize: 14),
              ),
            ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeviceConnectionScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Acepto y Continuar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}