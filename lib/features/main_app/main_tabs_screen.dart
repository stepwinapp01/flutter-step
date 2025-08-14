import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'goals_screen.dart';
import 'rewards_screen.dart';
import 'progress_screen.dart';
import '../../screens/community_screen.dart';
import '../coach/presentation/coach_adan_screen.dart';
import 'wallet_screen.dart';
import 'settings_screen.dart';


/// Pantalla principal con 6 tabs de navegación
class MainTabsScreen extends StatefulWidget {
  final String language;
  
  const MainTabsScreen({
    super.key,
    required this.language,
  });

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _currentIndex = 0;

  final Map<String, Map<String, String>> _translations = {
    'es': {
      'home': 'Inicio',
      'goals': 'Metas',
      'rewards': 'Recompensas',
      'progress': 'Progreso',
      'community': 'Comunidad',
      'wallet': 'Wallet',
      'coach': 'Coach Adán',
      'settings': 'Ajustes',
    },
    'en': {
      'home': 'Home',
      'goals': 'Goals',
      'rewards': 'Rewards',
      'progress': 'Progress',
      'community': 'Community',
      'wallet': 'Wallet',
      'coach': 'Coach Adán',
      'settings': 'Settings',
    },
  };

  String _getText(String key) {
    return _translations[widget.language]?[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(language: widget.language),
      GoalsScreen(language: widget.language),
      RewardsScreen(language: widget.language),
      ProgressScreen(language: widget.language),
      const CommunityScreen(),
      WalletScreen(language: widget.language),
      const CoachAdanScreen(),
      SettingsScreen(language: widget.language),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                _buildNavItem(0, Icons.home, _getText('home')),
                _buildNavItem(1, Icons.track_changes, _getText('goals')),
                _buildNavItem(2, Icons.stars, _getText('rewards')),
                _buildNavItem(3, Icons.trending_up, _getText('progress')),
                _buildNavItem(4, Icons.group, _getText('community')),
                _buildNavItem(5, Icons.account_balance_wallet, _getText('wallet')),
                _buildNavItem(6, Icons.psychology, _getText('coach')),
                _buildNavItem(7, Icons.settings, _getText('settings')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFF6B46C1).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? const Color(0xFF6B46C1)
                  : Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected 
                    ? const Color(0xFF6B46C1)
                    : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}