import 'package:flutter/material.dart';

/// Pantalla simple de términos y niveles
class LevelTermsScreen extends StatelessWidget {
  const LevelTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Términos y Niveles'),
        backgroundColor: const Color(0xFF6B46C1),
        foregroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sistema de Niveles Step Win',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Nivel 1: Despertar (0-1000 tokens)\n'
              'Nivel 2: Caminar (1001-5000 tokens)\n'
              'Nivel 3: Trotar (5001-15000 tokens)\n'
              'Nivel 4: Correr (15001-50000 tokens)\n'
              'Nivel 5: Atleta (50001+ tokens)',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 30),
            Text(
              'Términos de Uso',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Al usar Step Win aceptas nuestros términos de servicio y política de privacidad.',
              style: TextStyle(fontSize: 16),
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