import 'package:flutter/material.dart';
import '../onboarding/phone_registration_screen.dart';

/// Pantalla completa del sistema de niveles
class LevelsSystemScreen extends StatefulWidget {
  final bool isOnboarding;
  
  const LevelsSystemScreen({
    super.key,
    this.isOnboarding = false,
  });

  @override
  State<LevelsSystemScreen> createState() => _LevelsSystemScreenState();
}

class _LevelsSystemScreenState extends State<LevelsSystemScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> levels = [
    {
      'level': 1,
      'name': 'Despertar',
      'description': 'Primeros pasos en tu transformación',
      'tokens': '0 - 1,000',
      'color': Color(0xFF10B981),
      'icon': '🌅',
      'benefits': [
        'Acceso básico a la app',
        'Seguimiento de pasos',
        'Chat con Coach Adán',
        'Crear equipo',
      ],
    },
    {
      'level': 2,
      'name': 'Explorar',
      'description': 'Descubriendo nuevas posibilidades',
      'tokens': '1,001 - 5,000',
      'color': Color(0xFF3B82F6),
      'icon': '🔍',
      'benefits': [
        'Seguimiento de agua',
        'Metas personalizadas',
        'Acceso a comunidad',
        'Recompensas básicas',
      ],
    },
    {
      'level': 3,
      'name': 'Construir',
      'description': 'Formando hábitos saludables',
      'tokens': '5,001 - 15,000',
      'color': Color(0xFF8B5CF6),
      'icon': '🏗️',
      'benefits': [
        'Seguimiento de sueño',
        'Planes avanzados',
        'Competencias grupales',
        'Tokens extra',
      ],
    },
    {
      'level': 4,
      'name': 'Florecer',
      'description': 'Crecimiento y desarrollo',
      'tokens': '15,001 - 50,000',
      'color': Color(0xFFF59E0B),
      'icon': '🌸',
      'benefits': [
        'Análisis detallado',
        'Coach personalizado',
        'Eventos exclusivos',
        'Retiros premium',
      ],
    },
    {
      'level': 5,
      'name': 'Brillar',
      'description': 'Alcanzando la excelencia',
      'tokens': '50,001 - 100,000',
      'color': Color(0xFFEF4444),
      'icon': '✨',
      'benefits': [
        'Mentorías 1:1',
        'Acceso VIP',
        'Recompensas premium',
        'Certificaciones',
      ],
    },
    {
      'level': 6,
      'name': 'Trascender',
      'description': 'Superando todos los límites',
      'tokens': '100,001 - 500,000',
      'color': Color(0xFF7C3AED),
      'icon': '🚀',
      'benefits': [
        'Programa élite',
        'Networking exclusivo',
        'Inversiones especiales',
        'Liderazgo comunitario',
      ],
    },
    {
      'level': 7,
      'name': 'Leyenda',
      'description': 'El nivel más alto de maestría',
      'tokens': '500,001+',
      'color': Color(0xFFDC2626),
      'icon': '👑',
      'benefits': [
        'Estatus de leyenda',
        'Beneficios ilimitados',
        'Influencia global',
        'Legado permanente',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2937),
      appBar: widget.isOnboarding ? null : AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Sistema de Niveles',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          if (widget.isOnboarding) ...[
            const SizedBox(height: 60),
            const Text(
              '🎯 Sistema de Niveles',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Conoce los 7 niveles de transformación',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
          ],
          
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: levels.length,
              itemBuilder: (context, index) {
                final level = levels[index];
                return _buildLevelCard(level);
              },
            ),
          ),
          
          // Indicadores de página
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              levels.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index 
                      ? Colors.white 
                      : Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Botones de navegación
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                if (_currentPage > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Anterior',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                
                if (_currentPage > 0) const SizedBox(width: 16),
                
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentPage == levels.length - 1
                        ? () {
                            if (widget.isOnboarding) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PhoneRegistrationScreen(language: 'es'),
                                ),
                              );
                            } else {
                              Navigator.pop(context, true);
                            }
                          }
                        : () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1F2937),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      _currentPage == levels.length - 1 
                          ? (widget.isOnboarding ? 'Continuar' : 'Cerrar')
                          : 'Siguiente',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(Map<String, dynamic> level) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                level['color'],
                level['color'].withOpacity(0.8),
              ],
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header del nivel
              Row(
                children: [
                  Text(
                    level['icon'],
                    style: const TextStyle(fontSize: 40),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nivel ${level['level']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          level['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Descripción
              Text(
                level['description'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Tokens requeridos
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${level['tokens']} tokens',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Beneficios
              const Text(
                'Beneficios:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              Expanded(
                child: ListView.builder(
                  itemCount: level['benefits'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              level['benefits'][index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}