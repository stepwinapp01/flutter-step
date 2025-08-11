import 'package:flutter/material.dart';
import '../core/theme/app_constants.dart';

class TeamChatScreen extends StatelessWidget {
  const TeamChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat del Equipo'),
        backgroundColor: AppConstants.primaryPurple,
      ),
      body: const Center(
        child: Text(
          'Chat del equipo - Próximamente',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}