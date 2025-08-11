import 'package:flutter/material.dart';

/// Pantalla de felicitaciones por subir de nivel
class LevelCongratulationsScreen extends StatefulWidget {
  final int newLevel;
  final String levelName;
  final List<String> benefits;
  
  const LevelCongratulationsScreen({
    super.key,
    required this.newLevel,
    required this.levelName,
    required this.benefits,
  });

  @override
  State<LevelCongratulationsScreen> createState() => _LevelCongratulationsScreenState();
}

class _LevelCongratulationsScreenState extends State<LevelCongratulationsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final _teamNameController = TextEditingController();
  bool _showTeamCreation = false;
  bool _isCreatingTeam = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
    
    // Mostrar opción de crear equipo solo en nivel 1
    _showTeamCreation = widget.newLevel == 1;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _teamNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B46C1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              
              // Animación de felicitaciones
              ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  children: [
                    // Emoji de celebración
                    const Text(
                      '🎉',
                      style: TextStyle(fontSize: 80),
                    ),
                    const SizedBox(height: 20),
                    
                    // Título
                    const Text(
                      '¡Felicitaciones!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    
                    // Nuevo nivel
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Nivel ${widget.newLevel}: ${widget.levelName}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Beneficios desbloqueados
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Beneficios Desbloqueados:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...widget.benefits.map((benefit) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              benefit,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
              
              // Opción de crear equipo (solo nivel 1)
              if (_showTeamCreation) ...[
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.group_add, color: Color(0xFF6B46C1)),
                          SizedBox(width: 12),
                          Text(
                            '¡Crea tu Equipo!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Ahora puedes crear tu propio equipo e invitar amigos.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _teamNameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre del equipo',
                          hintText: 'Ej: Los Caminantes',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.group),
                        ),
                        maxLength: 20,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isCreatingTeam ? null : _createTeam,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6B46C1),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: _isCreatingTeam
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Crear Equipo',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const Spacer(),
              
              // Botón continuar
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6B46C1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
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

  void _createTeam() async {
    if (_teamNameController.text.trim().isEmpty) {
      _showSnackBar('Por favor ingresa un nombre para el equipo');
      return;
    }

    setState(() => _isCreatingTeam = true);

    // Simular validación de nombre único
    await Future.delayed(const Duration(seconds: 2));

    // Simular verificación (en la app real sería una consulta a la base de datos)
    final teamName = _teamNameController.text.trim();
    final existingTeams = ['Los Guerreros', 'Team Alpha', 'Fitness Masters'];
    
    if (existingTeams.contains(teamName)) {
      setState(() => _isCreatingTeam = false);
      _showSnackBar('Este nombre ya existe. Prueba con otro.');
      return;
    }

    // Equipo creado exitosamente
    setState(() => _isCreatingTeam = false);
    _showSnackBar('¡Equipo "$teamName" creado exitosamente!');
    
    // Ocultar la sección de creación de equipo
    setState(() => _showTeamCreation = false);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF6B46C1),
      ),
    );
  }
}