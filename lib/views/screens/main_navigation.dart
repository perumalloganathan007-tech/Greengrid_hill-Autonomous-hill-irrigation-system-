import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import 'dashboard_screen.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'admin_users_screen.dart';

/// Main navigation widget with bottom navigation bar
class MainNavigation extends StatefulWidget {
  final Function(ThemeMode)? onThemeChanged;
  final UserModel? user;
  
  const MainNavigation({super.key, this.onThemeChanged, this.user});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late List<Widget> _screens;
  late List<NavigationDestination> _destinations;

  @override
  void initState() {
    super.initState();
    _initializeNavigation();
  }

  void _initializeNavigation() {
    final isAdmin = widget.user?.isAdmin ?? false;

    if (isAdmin) {
      _screens = [
        const AdminUsersScreen(),
        const AnalyticsScreen(),
        SettingsScreen(onThemeChanged: widget.onThemeChanged ?? (_) {}),
        const ProfileScreen(),
      ];

      _destinations = [
        const NavigationDestination(
          icon: Icon(Icons.admin_panel_settings_outlined),
          selectedIcon: Icon(Icons.admin_panel_settings),
          label: 'Dashboard',
        ),
        const NavigationDestination(
          icon: Icon(Icons.analytics_outlined),
          selectedIcon: Icon(Icons.analytics),
          label: 'Analytics',
        ),
        const NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
        const NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ];
    } else {
      _screens = [
        const DashboardScreen(),
        const AnalyticsScreen(),
        SettingsScreen(onThemeChanged: widget.onThemeChanged ?? (_) {}),
        const ProfileScreen(),
      ];

      _destinations = [
        const NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        const NavigationDestination(
          icon: Icon(Icons.analytics_outlined),
          selectedIcon: Icon(Icons.analytics),
          label: 'Analytics',
        ),
        const NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
        const NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
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
        destinations: _destinations,
      ),
    );
  }
}
