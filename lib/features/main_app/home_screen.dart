import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/models/user_model.dart';
import '../../shared/services/user_service.dart';
import '../auth/google_auth_screen.dart';

/// Pantalla de inicio con dashboard principal
class HomeScreen extends StatefulWidget {
  final String language;
  
  const HomeScreen({
    super.key,
    required this.language,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? _user;
  bool _isLoading = true;

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
    return _translations[widget.language]?[key] ?? key;
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      print('Loading user data...');
      final user = await UserService.getUserProfile();
      print('User data loaded: ${user?.name ?? 'null'}');
      
      if (mounted) {
        setState(() {
          _user = user;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
      
      // Intentar crear un usuario básico si no existe
      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          print('Creating basic user profile...');
          final basicUser = UserModel(
            uid: currentUser.uid,
            email: currentUser.email ?? '',
            name: currentUser.displayName ?? 'Usuario',
            level: 1,
            plan: 'basic',
            tokenBalance: 0,
            kycVerified: false,
            facialRecognitionDone: false,
            language: widget.language,
            createdAt: DateTime.now(),
            lastActive: DateTime.now(),
            connectedDevices: {},
            hasCompletedOnboarding: true,
          );
          
          await UserService.saveUserProfile(basicUser);
          
          if (mounted) {
            setState(() {
              _user = basicUser;
              _isLoading = false;
            });
          }
          return;
        }
      } catch (createError) {
        print('Error creating basic user: $createError');
      }
      
      if (mounted) {
        setState(() {
          _user = null;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF6B46C1),
          ),
        ),
      );
    }

    if (_user == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'No se pudieron cargar los datos del usuario.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _loadUserData(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Reintentar'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _logout(context),
                child: const Text('Volver a iniciar sesión'),
              ),
            ],
          ),
        ),
      );
    }

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
                    backgroundImage: _user!.photoUrl != null
                        ? NetworkImage(_user!.photoUrl!)
                        : null,
                    backgroundColor: const Color(0xFF6B46C1),
                    child: _user!.photoUrl == null
                        ? Text(
                            (_user!.name.isNotEmpty ? _user!.name.substring(0, 1).toUpperCase() : 'U'),
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
                          '${_getText('welcome')} ${_user!.name.isNotEmpty ? _user!.name.split(' ')[0] : 'Usuario'}! 👋',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        Text(
                          '${_getText('level')} ${_user!.level} • ${_user!.plan.toUpperCase()}',
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
                      '5420',
                      '8000',
                      0.68,
                      Icons.directions_walk,
                      const Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildProgressCard(
                      _getText('tokens'),
                      '125',
                      '200',
                      0.63,
                      Icons.stars,
                      const Color(0xFFF59E0B),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Mensaje de bienvenida
              Container(
                width: double.infinity,
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
                  children: [
                    const Icon(
                      Icons.celebration,
                      size: 48,
                      color: Color(0xFF6B46C1),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '¡Bienvenido a Step Win!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tu viaje hacia una vida más saludable comienza aquí.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
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

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const GoogleAuthScreen(),
        ),
        (route) => false,
      );
    }
  }
}