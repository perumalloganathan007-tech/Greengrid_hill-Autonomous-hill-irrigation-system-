import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Service for logging user actions (audit trail)
class AuditService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const String _auditLogsPath = 'audit_logs';

  /// Log a user action
  Future<void> logAction({
    required String action,
    required String category,
    String? details,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final logEntry = {
        'userId': user.uid,
        'userEmail': user.email ?? 'unknown',
        'action': action,
        'category': category,
        'details': details,
        'timestamp': timestamp,
        'timestampReadable': DateTime.now().toIso8601String(),
        'metadata': metadata ?? {},
      };

      await _database
          .ref(_auditLogsPath)
          .child(user.uid)
          .child(timestamp.toString())
          .set(logEntry);
    } catch (e) {
      // Don't throw error if audit logging fails
      print('Failed to log action: $e');
    }
  }

  /// Log pump control action
  Future<void> logPumpControl({
    required String pumpId,
    required bool activated,
    String? mode,
  }) async {
    await logAction(
      action: activated ? 'Pump Activated' : 'Pump Deactivated',
      category: 'pump_control',
      details: 'Pump $pumpId ${activated ? "turned on" : "turned off"}',
      metadata: {
        'pumpId': pumpId,
        'activated': activated,
        'mode': mode,
      },
    );
  }

  /// Log emergency stop
  Future<void> logEmergencyStop() async {
    await logAction(
      action: 'Emergency Stop',
      category: 'emergency',
      details: 'All pumps emergency stopped',
      metadata: {'severity': 'critical'},
    );
  }

  /// Log settings change
  Future<void> logSettingsChange({
    required String setting,
    required dynamic oldValue,
    required dynamic newValue,
  }) async {
    await logAction(
      action: 'Settings Changed',
      category: 'settings',
      details: 'Changed $setting from $oldValue to $newValue',
      metadata: {
        'setting': setting,
        'oldValue': oldValue.toString(),
        'newValue': newValue.toString(),
      },
    );
  }

  /// Log user login
  Future<void> logLogin() async {
    await logAction(
      action: 'User Login',
      category: 'authentication',
      details: 'User signed in',
    );
  }

  /// Log user logout
  Future<void> logLogout() async {
    await logAction(
      action: 'User Logout',
      category: 'authentication',
      details: 'User signed out',
    );
  }

  /// Log user management action
  Future<void> logUserManagement({
    required String action,
    required String targetUserId,
    String? details,
  }) async {
    await logAction(
      action: action,
      category: 'user_management',
      details: details,
      metadata: {'targetUserId': targetUserId},
    );
  }

  /// Get audit logs for a specific user
  Future<List<Map<String, dynamic>>> getUserLogs(String userId) async {
    try {
      final snapshot = await _database
          .ref(_auditLogsPath)
          .child(userId)
          .orderByChild('timestamp')
          .limitToLast(100)
          .get();

      if (!snapshot.exists) return [];

      final logs = <Map<String, dynamic>>[];
      final data = snapshot.value as Map<dynamic, dynamic>?;
      
      if (data != null) {
        data.forEach((key, value) {
          if (value is Map) {
            logs.add(Map<String, dynamic>.from(value));
          }
        });
      }

      // Sort by timestamp descending
      logs.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
      return logs;
    } catch (e) {
      print('Failed to get user logs: $e');
      return [];
    }
  }

  /// Get all audit logs (admin only)
  Future<List<Map<String, dynamic>>> getAllLogs({int limit = 100}) async {
    try {
      final snapshot = await _database.ref(_auditLogsPath).get();

      if (!snapshot.exists) return [];

      final logs = <Map<String, dynamic>>[];
      final data = snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        data.forEach((userId, userLogs) {
          if (userLogs is Map) {
            userLogs.forEach((timestamp, logEntry) {
              if (logEntry is Map) {
                logs.add(Map<String, dynamic>.from(logEntry));
              }
            });
          }
        });
      }

      // Sort by timestamp descending
      logs.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
      
      // Limit results
      return logs.take(limit).toList();
    } catch (e) {
      print('Failed to get all logs: $e');
      return [];
    }
  }

  /// Stream of audit logs for real-time updates (admin only)
  Stream<List<Map<String, dynamic>>> getLogsStream() {
    return _database
        .ref(_auditLogsPath)
        .limitToLast(50)
        .onValue
        .map((event) {
      final logs = <Map<String, dynamic>>[];
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        data.forEach((userId, userLogs) {
          if (userLogs is Map) {
            userLogs.forEach((timestamp, logEntry) {
              if (logEntry is Map) {
                logs.add(Map<String, dynamic>.from(logEntry));
              }
            });
          }
        });
      }

      // Sort by timestamp descending
      logs.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
      return logs;
    });
  }
}
