import 'package:flutter/material.dart';
import '../shared/constants/app_icons.dart';

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
          unselectedLabelColor: Colors.white70,
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
          const _FeedTab(),
          _LeaderTab(onChatWithLeader: () => _showChatModal('Líder')),
          _TeamTab(
            onTeamChat: () => _showChatModal('Equipo'),
            onMemberChat: (name) => _showChatModal(name),
          ),
        ],
      ),
    );
  }

  void _showChatModal(String title) {
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

class _FeedTab extends StatelessWidget {
  const _FeedTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Feed - En desarrollo'),
    );
  }
}

class _LeaderTab extends StatelessWidget {
  final VoidCallback onChatWithLeader;
  
  const _LeaderTab({required this.onChatWithLeader});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Mi Líder - En desarrollo'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onChatWithLeader,
            child: const Text('Chat con Líder'),
          ),
        ],
      ),
    );
  }
}

class _TeamTab extends StatelessWidget {
  final VoidCallback onTeamChat;
  final Function(String) onMemberChat;
  
  const _TeamTab({required this.onTeamChat, required this.onMemberChat});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Mi Equipo - En desarrollo'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onTeamChat,
            child: const Text('Chat de Equipo'),
          ),
        ],
      ),
    );
  }
}