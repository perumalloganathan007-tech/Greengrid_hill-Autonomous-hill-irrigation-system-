import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';
import '../../viewmodels/auth_bloc.dart';
import '../../viewmodels/auth_event.dart';
import '../widgets/creative_logout_dialog.dart';
import '../widgets/network_status_indicator.dart';
import 'admin_activity_monitor_screen.dart';
import 'admin_tickets_screen.dart';
import '../../l10n/app_localizations.dart';

/// Screen for admins to view and manage registered users
class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final UserService _userService = UserService();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showLogoutDialog() {
    debugPrint('AdminUsersScreen: _showLogoutDialog called');
    final parentContext = context;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Logout',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => CreativeLogoutDialog(
        onLogout: () {
          debugPrint('AdminUsersScreen: onLogout callback triggered');
          parentContext.read<AuthBloc>().add(const LogoutRequested());
        },
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.adminDashboard),
          bottom: TabBar(
            tabs: [
              Tab(icon: const Icon(Icons.people), text: l10n.users),
              Tab(icon: const Icon(Icons.support_agent), text: l10n.tickets),
            ],
            indicatorColor: const Color(0xFF00E5FF),
            labelColor: const Color(0xFF00E5FF),
            unselectedLabelColor: Colors.white70,
          ),
          actions: [
            const NetworkStatusIndicator(),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _showLogoutDialog,
              tooltip: l10n.logout,
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: TabBarView(
          children: [
            // Tab 1: Users
            Column(
              children: [
                _buildSearchBar(l10n),
                Expanded(
            child: StreamBuilder<List<UserModel>>(
              stream: _userService.getUsersStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF00E5FF)),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${l10n.errorLoadingUsers}: ${snapshot.error}',
                      style: const TextStyle(color: Color(0xFFFF1744)),
                    ),
                  );
                }

                var users = snapshot.data ?? [];

                // Only list out registered regular users, exclude admins
                users = users.where((user) => !user.isAdmin).toList();

                // Apply search filter
                if (_searchQuery.isNotEmpty) {
                  final query = _searchQuery.toLowerCase();
                  users = users.where((user) {
                    return user.displayName.toLowerCase().contains(query) ||
                        user.uid.toLowerCase().contains(query);
                  }).toList();
                }

                if (users.isEmpty) {
                  return Center(
                    child: Text(
                      _searchQuery.isEmpty
                          ? l10n.noRegisteredUsers
                          : l10n.noUsersMatching(_searchQuery),
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return _buildUserCard(context, user, l10n);
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Tab 2: Tickets
      const AdminTicketsScreen(),
      ],
      ),
      ),
    );
  }

  Widget _buildSearchBar(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: l10n.searchByUsernameOrId,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          icon: const Icon(Icons.search, color: Color(0xFF00E5FF)),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, UserModel user, AppLocalizations l10n) {
    final bool isAdmin = user.isAdmin;
    final primaryColor = isAdmin
        ? const Color(0xFF00E676)
        : const Color(0xFF00E5FF);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 8,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AdminActivityMonitorScreen(targetUser: user),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: primaryColor.withValues(alpha: 0.1),
                child: Text(
                  user.displayName.isNotEmpty
                      ? user.displayName[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      border: Border.all(color: primaryColor.withValues(alpha: 0.1)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isAdmin ? l10n.adminLabel : l10n.userLabel,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
