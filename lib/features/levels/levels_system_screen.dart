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
      'name': 'Semilla',
      'description': 'El comienzo de tu transformación',
      'subscription': '\$11 USD',
      'members': '0 miembros activos',
      'monthly': '\$0 ganancia mensual',
      'bonus': '\$0 bono cumplimiento',
      'equipment': 'No aplica',
      'color': Color(0xFF10B981),
      'icon': '🌱',
    },
    {
      'level': 2,
      'name': 'Explorador',
      'description': 'Descubriendo nuevas posibilidades',
      'subscription': '\$11 USD',
      'members': '3 miembros activos',
      'monthly': '\$5 ganancia mensual',
      'bonus': 'Hasta \$2',
      'equipment': 'Hasta \$3',
      'color': Color(0xFF3B82F6),
      'icon': '🔍',
    },
    {
      'level': 3,
      'name': 'Despertar',
      'description': 'Despertando tu potencial',
      'subscription': '\$18 USD',
      'members': '5 miembros activos',
      'monthly': '\$15 ganancia mensual',
      'bonus': 'Hasta \$5',
      'equipment': 'Hasta \$10',
      'color': Color(0xFF8B5CF6),
      'icon': '🌅',
    },
    {
      'level': 4,
      'name': 'Ascenso',
      'description': 'Elevando tu nivel de vida',
      'subscription': '\$18 USD',
      'members': '10 miembros activos',
      'monthly': '\$30 ganancia mensual',
      'bonus': 'Hasta \$8',
      'equipment': 'Hasta \$15',
      'color': Color(0xFFF59E0B),
      'icon': '⬆️',
    },
    {
      'level': 5,
      'name': 'Sabio',
      'description': 'Sabiduría y conocimiento',
      'subscription': '\$25 USD',
      'members': '20 miembros activos',
      'monthly': '\$50 ganancia mensual',
      'bonus': 'Hasta \$12',
      'equipment': 'Hasta \$25',
      'color': Color(0xFF6366F1),
      'icon': '🧙‍♂️',
    },
    {
      'level': 6,
      'name': 'Líder',
      'description': 'Liderando con el ejemplo',
      'subscription': '\$25 USD',
      'members': '30 miembros activos',
      'monthly': '\$75 ganancia mensual',
      'bonus': 'Hasta \$18',
      'equipment': 'Hasta \$35',
      'color': Color(0xFFEF4444),
      'icon': '👑',
    },
    {
      'level': 7,
      'name': 'Maestro',
      'description': 'Maestría en todos los aspectos',
      'subscription': '\$25 USD',
      'members': '50 miembros activos',
      'monthly': '\$100 ganancia mensual',
      'bonus': 'Hasta \$25',
      'equipment': 'Hasta \$50',
      'color': Color(0xFF7C3AED),
      'icon': '🎓',
    },
    {
      'level': 8,
      'name': 'Guerrero',
      'description': 'Fuerza y determinación',
      'subscription': '\$25 USD',
      'members': '80 miembros activos',
      'monthly': '\$150 ganancia mensual',
      'bonus': 'Hasta \$35',
      'equipment': 'Hasta \$80',
      'color': Color(0xFFDC2626),
      'icon': '⚔️',
    },
    {
      'level': 9,
      'name': 'Campeón',
      'description': 'Campeón de la transformación',
      'subscription': '\$25 USD',
      'members': '90 miembros activos',
      'monthly': '\$200 ganancia mensual',
      'bonus': 'Hasta \$50',
      'equipment': 'Hasta \$100',
      'color': Color(0xFFF59E0B),
      'icon': '🏆',
    },
    {
      'level': 10,
      'name': 'Gladiador',
      'description': 'El nivel más alto de maestría',
      'subscription': '\$25 USD',
      'members': '100 miembros activos',
      'monthly': '\$300 ganancia mensual',
      'bonus': 'Hasta \$75',
      'equipment': 'Hasta \$150',
      'color': Color(0xFF059669),
      'icon': '🏛️',
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
              'Conoce los 10 niveles de transformación',
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
              
              const SizedBox(height: 24),
              
              // Información organizada en columnas
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Primera fila - Suscripción y Miembros
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoColumn(
                            '💳',
                            'Suscripción',
                            level['subscription'],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        Expanded(
                          child: _buildInfoColumn(
                            '👥',
                            'Miembros',
                            level['members'],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Línea divisoria
                    Container(
                      height: 1,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Segunda fila - Ganancia y Bonos
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoColumn(
                            '💰',
                            'Ganancia',
                            level['monthly'],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        Expanded(
                          child: _buildInfoColumn(
                            '🎁',
                            'Bono Cumplimiento',
                            level['bonus'],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Línea divisoria
                    Container(
                      height: 1,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Tercera fila - Bono Equipo (centrado)
                    _buildInfoColumn(
                      '🏋️',
                      'Bono Equipo',
                      level['equipment'],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String icon, String label, String value) {
    return Column(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}