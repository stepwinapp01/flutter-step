import 'package:flutter/material.dart';
import '../../shared/services/mock_data_service.dart';
import '../../shared/services/user_service.dart';
import '../onboarding/simple_welcome_screen.dart';

/// Pantalla de inicio con dashboard principal
class HomeScreen extends StatelessWidget {
  final String language;
  
  const HomeScreen({
    super.key,
    required this.language,
  });

  final Map<String, Map<String, String>> _translations = const {
    'es': {
      'welcome': '¡Hola',
      'todayProgress': 'Progreso de Hoy',
      'steps': 'Pasos',
      'tokens': 'Tokens',
      'level': 'Nivel',
      'quickActions': 'Acciones Rápidas',
      'logSteps': 'Registrar Pasos',
      'logWater': 'Registrar Agua',
      'meditate': 'Meditar',
      'chatCoach': 'Chat Coach',
      'recentActivity': 'Actividad Reciente',
      'teamUpdates': 'Actualizaciones del Equipo',
      'viewAll': 'Ver Todo',
    },
    'en': {
      'welcome': 'Hello',
      'todayProgress': 'Today\'s Progress',
      'steps': 'Steps',
      'tokens': 'Tokens',
      'level': 'Level',
      'quickActions': 'Quick Actions',
      'logSteps': 'Log Steps',
      'logWater': 'Log Water',
      'meditate': 'Meditate',
      'chatCoach': 'Chat Coach',
      'recentActivity': 'Recent Activity',
      'teamUpdates': 'Team Updates',
      'viewAll': 'View All',
    },
  };

  String _getText(String key) {
    return _translations[language]?[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final user = MockDataService.currentUser;
    final todayGoals = MockDataService.todayGoals;
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con saludo
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: user.photoUrl != null 
                        ? NetworkImage(user.photoUrl!)
                        : null,
                    backgroundColor: const Color(0xFF6B46C1),
                    child: user.photoUrl == null 
                        ? Text(
                            user.name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_getText('welcome')} ${UserService().userName.split(' ')[0]}! 👋',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        Text(
                          '${_getText('level')} ${user.level} • ${user.plan.toUpperCase()}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _showLogoutDialog(context),
                    icon: const Icon(Icons.logout, color: Colors.red),
                    tooltip: 'Cerrar Sesión',
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Progreso de hoy
              Text(
                _getText('todayProgress'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildProgressCard(
                      _getText('steps'),
                      '${todayGoals.steps}',
                      '${todayGoals.targetSteps}',
                      todayGoals.steps / todayGoals.targetSteps,
                      Icons.directions_walk,
                      const Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildProgressCard(
                      _getText('tokens'),
                      '${todayGoals.tokensEarned.toInt()}',
                      '200',
                      todayGoals.tokensEarned / 200,
                      Icons.stars,
                      const Color(0xFFF59E0B),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Acciones rápidas
              Text(
                _getText('quickActions'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildQuickAction(
                      _getText('logSteps'),
                      Icons.directions_walk,
                      const Color(0xFF10B981),
                      () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickAction(
                      _getText('logWater'),
                      Icons.water_drop,
                      const Color(0xFF3B82F6),
                      () {},
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    child: _buildQuickAction(
                      _getText('meditate'),
                      Icons.self_improvement,
                      const Color(0xFF8B5CF6),
                      () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickAction(
                      _getText('chatCoach'),
                      Icons.psychology,
                      const Color(0xFF6B46C1),
                      () {},
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Actividad reciente
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getText('recentActivity'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(_getText('viewAll')),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Feed de comunidad y logros del equipo
              _buildCommunityFeed(),
              
              const SizedBox(height: 20),
              
              Text(
                'Logros de Mi Equipo',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              
              const SizedBox(height: 12),
              
              _buildTeamAchievements(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard(
    String title,
    String current,
    String target,
    double progress,
    IconData icon,
    Color color,
  ) {
    return Container(
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
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            current,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'de $target',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F2937),
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCommunityFeed() {
    final feedItems = [
      {
        'user': 'María González',
        'action': 'completó 12,000 pasos',
        'time': '1h',
        'avatar': 'M',
        'color': const Color(0xFF10B981),
      },
      {
        'user': 'Carlos Ruiz',
        'action': 'alcanzó nivel 3',
        'time': '3h',
        'avatar': 'C',
        'color': const Color(0xFF6B46C1),
      },
      {
        'user': 'Ana López',
        'action': 'ganó 50 tokens',
        'time': '5h',
        'avatar': 'A',
        'color': const Color(0xFFF59E0B),
      },
    ];
    
    return Column(
      children: feedItems.map((item) => Container(
        margin: const EdgeInsets.only(bottom: 12),
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
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: item['color'] as Color,
              child: Text(
                item['avatar'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1F2937),
                      ),
                      children: [
                        TextSpan(
                          text: item['user'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${item['action']}'),
                      ],
                    ),
                  ),
                  Text(
                    item['time'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.favorite_border,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      )).toList(),
    );
  }
  
  Widget _buildTeamAchievements() {
    final achievements = [
      {
        'title': 'Mi Líder: Roberto Silva',
        'subtitle': 'Completó 15,000 pasos hoy',
        'icon': Icons.emoji_events,
        'color': const Color(0xFFF59E0B),
      },
      {
        'title': 'Equipo: +5 miembros activos',
        'subtitle': 'Meta semanal alcanzada',
        'icon': Icons.group,
        'color': const Color(0xFF10B981),
      },
    ];
    
    return Column(
      children: achievements.map((achievement) => Container(
        margin: const EdgeInsets.only(bottom: 12),
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
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (achievement['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                achievement['icon'] as IconData,
                color: achievement['color'] as Color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement['title'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  Text(
                    achievement['subtitle'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Cerrar Sesión?'),
        content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _logout(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    UserService().clearUserData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleWelcomeScreen(),
      ),
      (route) => false,
    );
  }
}