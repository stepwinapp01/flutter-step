import 'package:flutter/material.dart';
import 'package:step_win_app/l10n/app_localizations.dart';
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
  const MainTabsScreen({super.key});

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
        final List<Widget> screens = [
      HomeScreen(language: 'es'),
      const GoalsScreen(language: 'es'),
      const RewardsScreen(language: 'es'),
      const ProgressScreen(language: 'es'),
      const CommunityScreen(),
      const WalletScreen(language: 'es'),
      const CoachAdanScreen(),
      const SettingsScreen(language: 'es'),
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
                _buildNavItem(0, Icons.home, l10n.home),
                _buildNavItem(1, Icons.track_changes, l10n.goals),
                _buildNavItem(2, Icons.stars, l10n.rewards),
                _buildNavItem(3, Icons.trending_up, l10n.progress),
                _buildNavItem(4, Icons.group, l10n.community),
                _buildNavItem(5, Icons.account_balance_wallet, 'Wallet'),
                _buildNavItem(6, Icons.psychology, l10n.coach),
                _buildNavItem(7, Icons.settings, 'Settings'),
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
              ? const Color(0xFF6B46C1).withAlpha(26)
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