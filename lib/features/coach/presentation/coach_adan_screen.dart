import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_constants.dart';
import '../../../shared/services/mock_data_service.dart';
import '../models/chat_message.dart';
import '../providers/chat_provider.dart';
import '../../subscription/subscription_plans_screen.dart';

class CoachAdanScreen extends StatefulWidget {
  const CoachAdanScreen({super.key});

  @override
  State<CoachAdanScreen> createState() => _CoachAdanScreenState();
}

class _CoachAdanScreenState extends State<CoachAdanScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final user = MockDataService.currentUser;
  // final fitnessPlan = MockDataService.mockFitnessPlan;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppConstants.white,
              child: Text(
                '🤖',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(width: 12),
            Text('Coach Adán'),
          ],
        ),
        backgroundColor: AppConstants.primaryPurple,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppConstants.white,
          labelColor: AppConstants.white,
          unselectedLabelColor: AppConstants.white.withValues(alpha: 0.7),
          tabs: const [
            Tab(text: 'Chat'),
            Tab(text: 'Mi Plan'),
            Tab(text: 'Consejos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatTab(),
          _buildPlanTab(),
          _buildTipsTab(),
        ],
      ),
    );
  }

  Widget _buildChatTab() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: context.watch<ChatProvider>().messages.length,
            itemBuilder: (context, index) {
              final message = context.watch<ChatProvider>().messages[index];
              return _buildChatBubble(message);
            },
          ),
        ),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppConstants.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  onPressed: _showQuickSuggestions,
                  icon: const Icon(
                    Icons.lightbulb_outline,
                    color: AppConstants.primaryPurple,
                  ),
                ),
                
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Pregúntame sobre salud y bienestar...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppConstants.lightGrey,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                
                const SizedBox(width: 8),
                
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: AppConstants.primaryPurple,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: AppConstants.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    final isCoach = message.isCoach;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isCoach ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isCoach) ...[
            const CircleAvatar(
              radius: 16,
              backgroundColor: AppConstants.primaryPurple,
              child: Text(
                '🤖',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
          ],
          
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isCoach 
                    ? AppConstants.lightGrey
                    : AppConstants.primaryPurple,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isCoach ? 4 : 16),
                  bottomRight: Radius.circular(isCoach ? 16 : 4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isCoach)
                    const Text(
                      'Coach Adán',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.primaryPurple,
                      ),
                    ),
                  if (isCoach) const SizedBox(height: 4),
                  Text(
                    message.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: isCoach ? AppConstants.black : AppConstants.white,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatMessageTime(message.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: isCoach 
                          ? AppConstants.grey
                          : AppConstants.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (!isCoach) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppConstants.primaryPurple.withValues(alpha: 0.1),
              child: Text(
                user.name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryPurple,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlanTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppConstants.primaryPurple, AppConstants.secondaryPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Mi Plan Personalizado',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Diseñado especialmente para ${user.name}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppConstants.white.withValues(alpha: 0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SubscriptionPlansScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppConstants.primaryPurple,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Comenzar mi Transformación',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          const Text(
            'Ejercicios de Hoy',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppConstants.black,
            ),
          ),
          const SizedBox(height: 12),
          
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppConstants.primaryPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.fitness_center,
                  color: AppConstants.primaryPurple,
                ),
              ),
              title: const Text('Caminata matutina'),
              subtitle: const Text('30 minutos de caminata'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppConstants.primaryPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.self_improvement,
                  color: AppConstants.primaryPurple,
                ),
              ),
              title: const Text('Meditación'),
              subtitle: const Text('10 minutos de relajación'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Consejos de Salud',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppConstants.black,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildTipCard(
            '💧',
            'Hidratación',
            'Bebe al menos 8 vasos de agua al día para mantener tu cuerpo hidratado.',
          ),
          
          _buildTipCard(
            '🥗',
            'Alimentación Balanceada',
            'Incluye frutas, verduras, proteínas y granos enteros en tu dieta diaria.',
          ),
          
          _buildTipCard(
            '😴',
            'Descanso',
            'Duerme entre 7-9 horas diarias para una recuperación óptima.',
          ),
          
          _buildTipCard(
            '🏃♂️',
            'Actividad Física',
            'Realiza al menos 30 minutos de ejercicio moderado 5 días a la semana.',
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(String emoji, String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 24),
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
                      color: AppConstants.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppConstants.grey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    
    context.read<ChatProvider>().sendUserMessage(text);
    _messageController.clear();
    _scrollToBottom();
  }



  void _showQuickSuggestions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sugerencias Rápidas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildSuggestionTile('¿Cómo puedo mejorar mi rutina?'),
            _buildSuggestionTile('¿Qué alimentos debo evitar?'),
            _buildSuggestionTile('¿Cuánto debo descansar entre ejercicios?'),
            _buildSuggestionTile('¿Cómo mantener la motivación?'),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionTile(String suggestion) {
    return ListTile(
      title: Text(suggestion),
      onTap: () {
        Navigator.pop(context);
        _messageController.text = suggestion;
        _sendMessage();
      },
    );
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatMessageTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'Ahora';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }
}