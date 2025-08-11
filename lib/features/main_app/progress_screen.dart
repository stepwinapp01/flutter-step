import 'package:flutter/material.dart';
import '../../shared/services/mock_data_service.dart';
import '../levels/level_congratulations_screen.dart';

/// Pantalla de progreso y niveles
class ProgressScreen extends StatefulWidget {
  final String language;
  
  const ProgressScreen({
    super.key,
    required this.language,
  });

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {

  @override
  Widget build(BuildContext context) {
    final user = MockDataService.currentUser;
    final levels = MockDataService.levels;
    final currentLevel = levels.firstWhere((level) => level['level'] == user.level);
    final nextLevel = user.level < 10 ? levels.firstWhere((level) => level['level'] == user.level + 1) : null;
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Progreso',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nivel actual
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B46C1), Color(0xFF9333EA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${user.level}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentLevel['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Plan ${user.plan.toUpperCase()}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Progreso al siguiente nivel
            if (nextLevel != null) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Próximo Nivel: ${nextLevel['name']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        Text(
                          'Nivel ${nextLevel['level']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildRequirement(
                      'Pasos mínimos diarios',
                      '${nextLevel['minSteps']}',
                      Icons.directions_walk,
                      const Color(0xFF10B981),
                    ),
                    const SizedBox(height: 8),
                    _buildRequirement(
                      'Tamaño del equipo',
                      '${nextLevel['teamSize']} miembros',
                      Icons.people,
                      const Color(0xFF3B82F6),
                    ),
                    const SizedBox(height: 8),
                    _buildRequirement(
                      'Límite de retiro mensual',
                      '\$${nextLevel['withdrawLimit']}',
                      Icons.account_balance_wallet,
                      const Color(0xFFF59E0B),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
            ],
            
            // Botón para simular subir de nivel (solo para demo)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 24),
              child: ElevatedButton(
                onPressed: _simulateLevelUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '🎉 Simular Subir de Nivel (Demo)',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            // Estadísticas
            const Text(
              'Estadísticas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Tokens Ganados',
                    '${user.tokenBalance.toInt()}',
                    Icons.stars,
                    const Color(0xFFF59E0B),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Días Activos',
                    '28',
                    Icons.calendar_today,
                    const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Pasos Totales',
                    '245K',
                    Icons.directions_walk,
                    const Color(0xFF3B82F6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Equipo',
                    '${user.teamCode != null ? "5" : "0"} miembros',
                    Icons.people,
                    const Color(0xFF8B5CF6),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Todos los niveles
            const Text(
              'Todos los Niveles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            
            const SizedBox(height: 16),
            
            ...levels.map((level) => _buildLevelItem(
              level['level'],
              level['name'],
              level['minSteps'],
              level['withdrawLimit'],
              user.level >= level['level'],
              user.level == level['level'],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirement(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF374151),
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelItem(
    int level,
    String name,
    int minSteps,
    int withdrawLimit,
    bool isUnlocked,
    bool isCurrent,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrent 
            ? const Color(0xFF6B46C1).withOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isCurrent 
            ? Border.all(color: const Color(0xFF6B46C1), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isUnlocked 
                  ? const Color(0xFF6B46C1).withOpacity(0.1)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '$level',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isUnlocked 
                      ? const Color(0xFF6B46C1)
                      : Colors.grey.shade500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isUnlocked 
                        ? const Color(0xFF1F2937)
                        : Colors.grey.shade500,
                  ),
                ),
                Text(
                  '$minSteps pasos • \$$withdrawLimit límite',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          if (isCurrent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF6B46C1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Actual',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            )
          else if (isUnlocked)
            const Icon(
              Icons.check_circle,
              color: Color(0xFF10B981),
              size: 20,
            )
          else
            Icon(
              Icons.lock,
              color: Colors.grey.shade400,
              size: 20,
            ),
        ],
      ),
    );
  }

  void _simulateLevelUp() {
    final user = MockDataService.currentUser;
    final newLevel = user.level + 1;
    
    final levelData = {
      1: {
        'name': 'Despertar',
        'benefits': [
          'Acceso básico a la plataforma',
          'Seguimiento de pasos diario',
          'Posibilidad de crear equipo',
          'Retiros hasta \$50/mes'
        ]
      },
      2: {
        'name': 'Caminar',
        'benefits': [
          'Bonificación del 10% en tokens',
          'Acceso a desafíos grupales',
          'Equipo de hasta 3 miembros',
          'Retiros hasta \$150/mes'
        ]
      },
    };
    
    final currentLevelData = levelData[newLevel] ?? {
      'name': 'Nivel Avanzado',
      'benefits': ['Beneficios exclusivos del nivel $newLevel']
    };
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LevelCongratulationsScreen(
          newLevel: newLevel,
          levelName: currentLevelData['name'] as String,
          benefits: List<String>.from(currentLevelData['benefits'] as List),
        ),
      ),
    );
  }
}