import 'package:flutter/material.dart';

/// Pantalla de comunidad con feed social y equipos
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidad'),
        backgroundColor: const Color(0xFF6B46C1),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Mi Líder'),
            Tab(text: 'Mi Equipo'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildLeaderTab(),
          _buildTeamTab(),
        ],
      ),
    );
  }

  Widget _buildFeedTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildPostCard(
            'María García',
            'assets/avatars/maria.jpg',
            '¡Acabo de completar mis 10,000 pasos! 🚀 #StepWin #Salud',
            '2h',
            45,
            12,
          ),
          _buildPostCard(
            'Carlos Ruiz',
            'assets/avatars/carlos.jpg',
            'Mi equipo está en el top 5 esta semana! 🏆 ¡Vamos por más!',
            '4h',
            32,
            8,
          ),
          _buildPostCard(
            'Ana López',
            'assets/avatars/ana.jpg',
            'Nuevo récord personal: 15,000 pasos en un día! 💪',
            '6h',
            67,
            15,
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B46C1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      'JD',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6B46C1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Juan Díaz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Tu Líder de Equipo',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('Nivel', '8'),
                      _buildStatColumn('Equipo', '25'),
                      _buildStatColumn('Tokens', '15.2K'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _showChatWithLeader(),
            icon: const Icon(Icons.chat),
            label: const Text('Chatear con mi Líder'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6B46C1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamTab() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mi Equipo (8 miembros)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showTeamChat(),
                icon: const Icon(Icons.chat, size: 16),
                label: const Text('Chat'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildTeamMember('Ana Martínez', 'Nivel 6', '8.5K tokens', true),
              _buildTeamMember('Carlos Vega', 'Nivel 5', '6.2K tokens', true),
              _buildTeamMember('Lucía Fernández', 'Nivel 7', '12.1K tokens', false),
              _buildTeamMember('Miguel Santos', 'Nivel 4', '4.8K tokens', true),
              _buildTeamMember('Elena Rodríguez', 'Nivel 6', '9.3K tokens', false),
              _buildTeamMember('David López', 'Nivel 3', '2.1K tokens', true),
              _buildTeamMember('Sofía Morales', 'Nivel 5', '7.6K tokens', true),
              _buildTeamMember('Roberto Jiménez', 'Nivel 4', '5.4K tokens', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostCard(String name, String avatar, String content, String time, int likes, int comments) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF6B46C1),
                  child: Text(
                    name[0],
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
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
                Text('$likes'),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline),
                ),
                Text('$comments'),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamMember(String name, String level, String tokens, bool isOnline) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF6B46C1),
              child: Text(
                name[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('$level • $tokens'),
        trailing: IconButton(
          onPressed: () => _showMemberChat(name),
          icon: const Icon(Icons.chat, color: Color(0xFF6B46C1)),
        ),
      ),
    );
  }

  void _showChatWithLeader() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: const Center(
          child: Text('Chat con Líder - En desarrollo'),
        ),
      ),
    );
  }

  void _showTeamChat() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: const Center(
          child: Text('Chat de Equipo - En desarrollo'),
        ),
      ),
    );
  }

  void _showMemberChat(String memberName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Center(
          child: Text('Chat con $memberName - En desarrollo'),
        ),
      ),
    );
  }
}