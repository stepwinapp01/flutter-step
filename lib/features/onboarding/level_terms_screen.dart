import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text('Términos y Niveles'),
        backgroundColor: const Color(0xFF6B46C1),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sistema de Niveles Step Win',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Niveles organizados en tarjetas
            _buildLevelCard('🌱', 'Nivel 1: Semilla', '0-1000 tokens', 'El comienzo de tu transformación'),
            const SizedBox(height: 12),
            _buildLevelCard('🔍', 'Nivel 2: Explorador', '1001-5000 tokens', 'Descubriendo nuevas posibilidades'),
            const SizedBox(height: 12),
            _buildLevelCard('🌅', 'Nivel 3: Despertar', '5001-15000 tokens', 'Despertando tu potencial'),
            const SizedBox(height: 12),
            _buildLevelCard('⬆️', 'Nivel 4: Ascenso', '15001-50000 tokens', 'Elevando tu nivel de vida'),
            const SizedBox(height: 12),
            _buildLevelCard('🧙♂️', 'Nivel 5: Sabio', '50001+ tokens', 'Sabiduría y conocimiento'),
            
            const SizedBox(height: 30),
            const Text(
              'Términos de Uso',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Al usar Step Win aceptas nuestros términos de servicio y política de privacidad.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6B46C1),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Acepto'),
        ),
      ),
    );
  }
}