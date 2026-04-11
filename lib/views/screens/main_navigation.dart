import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/user_model.dart';
import 'dashboard_screen.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'admin_users_screen.dart';

/// Main navigation widget with bottom navigation bar
class MainNavigation extends StatefulWidget {
  final Function(ThemeMode)? onThemeChanged;
  final Function(Locale)? onLocaleChanged;
  final UserModel? user;
  
  const MainNavigation({super.key, this.onThemeChanged, this.onLocaleChanged, this.user});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _initializeScreens();
  }

  void _initializeScreens() {
    final isAdmin = widget.user?.isAdmin ?? false;

    if (isAdmin) {
      _screens = [
        const AdminUsersScreen(),
        const AnalyticsScreen(),
        SettingsScreen(
          onThemeChanged: widget.onThemeChanged ?? (_) {},
          onLocaleChanged: widget.onLocaleChanged ?? (_) {},
        ),
        const ProfileScreen(),
      ];
    } else {
      _screens = [
        const DashboardScreen(),
        const AnalyticsScreen(),
        SettingsScreen(
          onThemeChanged: widget.onThemeChanged ?? (_) {},
          onLocaleChanged: widget.onLocaleChanged ?? (_) {},
        ),
        const ProfileScreen(),
      ];
    }
  }

  List<NavigationDestination> _getDestinations(BuildContext context) {
    final isAdmin = widget.user?.isAdmin ?? false;
    final l10n = AppLocalizations.of(context)!;

    if (isAdmin) {
      return [
        NavigationDestination(
          icon: const Icon(Icons.admin_panel_settings_outlined),
          selectedIcon: const Icon(Icons.admin_panel_settings),
          label: l10n.dashboard,
        ),
        NavigationDestination(
          icon: const Icon(Icons.analytics_outlined),
          selectedIcon: const Icon(Icons.analytics),
          label: l10n.analytics,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: l10n.settings,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: l10n.profile,
        ),
      ];
    } else {
      return [
        NavigationDestination(
          icon: const Icon(Icons.dashboard_outlined),
          selectedIcon: const Icon(Icons.dashboard),
          label: l10n.dashboard,
        ),
        NavigationDestination(
          icon: const Icon(Icons.analytics_outlined),
          selectedIcon: const Icon(Icons.analytics),
          label: l10n.analytics,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: l10n.settings,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: l10n.profile,
        ),
      ];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: _getDestinations(context),
      ),
    );
  }
}
