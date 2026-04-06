import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../services/audit_service.dart';

class AdminUserActivityTab extends StatefulWidget {
  final String userId;

  const AdminUserActivityTab({super.key, required this.userId});

  @override
  State<AdminUserActivityTab> createState() => _AdminUserActivityTabState();
}

class _AdminUserActivityTabState extends State<AdminUserActivityTab> {
  final AuditService _auditService = AuditService();
  late Future<List<Map<String, dynamic>>> _logsFuture;

  @override
  void initState() {
    super.initState();
    _fetchLogs();
  }

  void _fetchLogs() {
    setState(() {
      _logsFuture = _auditService.getUserLogs(widget.userId);
    });
  }

  /// Process logs into daily login counts for the last 7 days
  List<_LoginData> _processChartData(List<Map<String, dynamic>> logs) {
    final now = DateTime.now();
    final Map<String, int> dailyCounts = {};

    // Initialize last 7 days
    for (int i = 6; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      dailyCounts[DateFormat('MM/dd').format(day)] = 0;
    }

    // Count logins
    for (var log in logs) {
      final action = log['action']?.toString().toLowerCase() ?? '';
      if (action.contains('login')) {
        final timestamp = log['timestamp'] as int?;
        if (timestamp != null) {
          final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
          if (date.isAfter(now.subtract(const Duration(days: 7)))) {
            final dateString = DateFormat('MM/dd').format(date);
            if (dailyCounts.containsKey(dateString)) {
              dailyCounts[dateString] = dailyCounts[dateString]! + 1;
            }
          }
        }
      }
    }

    return dailyCounts.entries.map((e) => _LoginData(e.key, e.value)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _logsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF00E5FF)),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading logs: ${snapshot.error}',
              style: const TextStyle(color: Color(0xFFFF1744)),
            ),
          );
        }

        final logs = snapshot.data ?? [];
        final loginLogs = logs
            .where(
              (log) =>
                  log['category'] == 'authentication' ||
                  log['action'].toString().toLowerCase().contains('login') ||
                  log['action'].toString().toLowerCase().contains('logout'),
            )
            .toList();

        final chartData = _processChartData(loginLogs);

        return RefreshIndicator(
          onRefresh: () async {
            _fetchLogs();
          },
          child: CustomScrollView(
            slivers: [
              if (loginLogs.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'LOGIN FREQUENCY (7 DAYS)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00E5FF),
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 200,
                              child: SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                primaryXAxis: const CategoryAxis(
                                  majorGridLines: MajorGridLines(width: 0),
                                  labelStyle: TextStyle(color: Colors.grey),
                                ),
                                primaryYAxis: const NumericAxis(
                                  majorGridLines: MajorGridLines(
                                    width: 1,
                                    color: Colors.white10,
                                    dashArray: [5, 5],
                                  ),
                                  labelStyle: TextStyle(color: Colors.grey),
                                ),
                                series: <CartesianSeries<_LoginData, String>>[
                                  ColumnSeries<_LoginData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (_LoginData data, _) =>
                                        data.date,
                                    yValueMapper: (_LoginData data, _) =>
                                        data.count,
                                    color: const Color(0xFF00E5FF),
                                    borderRadius: BorderRadius.circular(4),
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (loginLogs.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.history, size: 48, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text(
                          'No login activity found.',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: _fetchLogs,
                          child: const Text(
                            'Refresh',
                            style: TextStyle(color: Color(0xFF00E5FF)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (loginLogs.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final log = loginLogs[index];
                      final timestamp = log['timestamp'] as int?;
                      final date = timestamp != null
                          ? DateTime.fromMillisecondsSinceEpoch(timestamp)
                          : DateTime.now();

                      final action = log['action'] ?? 'Unknown Action';
                      final isLogin = action.toString().toLowerCase().contains(
                        'login',
                      );
                      final color = isLogin
                          ? const Color(0xFF00E676)
                          : const Color(0xFFFF9100);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 4,
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(color: color.withValues(alpha: 0.1)),
                            ),
                            child: Icon(
                              isLogin ? Icons.login : Icons.logout,
                              color: color,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            action.toString().toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: color,
                              letterSpacing: 1.2,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            DateFormat('MMM dd, yyyy - hh:mm a').format(date),
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }, childCount: loginLogs.length),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _LoginData {
  _LoginData(this.date, this.count);
  final String date;
  final int count;
}
