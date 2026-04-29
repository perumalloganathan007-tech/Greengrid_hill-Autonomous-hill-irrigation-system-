import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import 'admin_user_activity_tab.dart';
import 'dashboard_screen.dart';
import 'analytics_screen.dart';
import '../../services/user_service.dart';
import '../../services/presence_service.dart';
import '../../l10n/app_localizations.dart';

/// Screen for Admins to monitor specific user activity
class AdminActivityMonitorScreen extends StatelessWidget {
  final UserModel targetUser;

  const AdminActivityMonitorScreen({super.key, required this.targetUser});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: StreamBuilder<UserModel>(
            stream: UserService().getUserStream(targetUser.uid),
            initialData: targetUser,
            builder: (context, snapshot) {
              final user = snapshot.data ?? targetUser;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: PresenceService().getPresenceStream(targetUser.uid),
                    initialData: targetUser.isOnline,
                    builder: (context, presenceSnapshot) {
                      final isOnline = presenceSnapshot.data ?? false;
                      return Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isOnline ? Colors.green : Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isOnline ? l10n.online : l10n.offline,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: isOnline
                                  ? Colors.green[200]
                                  : Colors.grey[400],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            },
          ),
          bottom: TabBar(
            indicatorColor: const Color(0xFF00E676),
            labelColor: const Color(0xFF00E676),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: const Icon(Icons.dashboard_outlined), text: l10n.telemetry.toUpperCase()),
              Tab(icon: const Icon(Icons.analytics_outlined), text: l10n.analytics.toUpperCase()),
              Tab(icon: const Icon(Icons.history_outlined), text: l10n.history.toUpperCase()),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DashboardScreen(userId: targetUser.uid),
            AnalyticsScreen(userId: targetUser.uid),
            AdminUserActivityTab(userId: targetUser.uid),
          ],
        ),
      ),
    );
  }
}
