import 'package:flutter/material.dart';
import '../../shared/widgets/onboarding_progress_indicator.dart';
import 'profile_completion_screen.dart';

class NotificationsSetupScreen extends StatefulWidget {
  const NotificationsSetupScreen({super.key});

  @override
  State<NotificationsSetupScreen> createState() => _NotificationsSetupScreenState();
}

class _NotificationsSetupScreenState extends State<NotificationsSetupScreen> {
  bool _workoutReminders = true;
  bool _progressUpdates = true;
  bool _socialNotifications = false;
  bool _coachTips = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgressIndicator(currentStep: 5, totalSteps: 7),
              const SizedBox(height: 32),
              const Text(
                'Configurar notificaciones',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Personaliza qué notificaciones quieres recibir',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                    _buildNotificationTile(
                      'Recordatorios de ejercicio',
                      'Te recordaremos cuando sea hora de entrenar',
                      Icons.fitness_center,
                      _workoutReminders,
                      (value) => setState(() => _workoutReminders = value),
                    ),
                    _buildNotificationTile(
                      'Actualizaciones de progreso',
                      'Celebra tus logros y metas alcanzadas',
                      Icons.trending_up,
                      _progressUpdates,
                      (value) => setState(() => _progressUpdates = value),
                    ),
                    _buildNotificationTile(
                      'Actividad social',
                      'Nuevos seguidores, likes y comentarios',
                      Icons.group,
                      _socialNotifications,
                      (value) => setState(() => _socialNotifications = value),
                    ),
                    _buildNotificationTile(
                      'Consejos del coach',
                      'Tips personalizados de tu coach IA',
                      Icons.psychology,
                      _coachTips,
                      (value) => setState(() => _coachTips = value),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continuar',
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

  Widget _buildNotificationTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF6B46C1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6B46C1),
              size: 24,
            ),
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
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF6B46C1),
          ),
        ],
      ),
    );
  }

  void _continue() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileCompletionScreen(),
      ),
    );
  }
}