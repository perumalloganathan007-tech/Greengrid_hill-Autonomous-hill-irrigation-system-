import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Service for monitoring real-time presence using Firebase Realtime Database.
/// Synchronizes presence status back to Firestore for consistent display.
class PresenceService {
  static final PresenceService _instance = PresenceService._internal();
  factory PresenceService() => _instance;
  PresenceService._internal();

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<DatabaseEvent>? _connectionSubscription;

  /// Initialize presence monitoring for the current user.
  /// Sets up an 'onDisconnect' hook in Realtime Database.
  void initialize(String uid) {
    _cleanup(); // Clear existing monitoring if any

    final DatabaseReference presenceRef = _database.ref('presence/$uid');
    final DocumentReference userDocRef = _firestore.collection('users').doc(uid);

    // Monitor the .info/connected special node in Realtime Database
    _connectionSubscription = _database.ref('.info/connected').onValue.listen((event) {
      final bool connected = event.snapshot.value as bool? ?? false;

      if (connected) {
        // 1. Set presence to true in Realtime Database
        presenceRef.set(true);

        // 2. Configure onDisconnect in Realtime Database (handled by Firebase Server)
        presenceRef.onDisconnect().set(false);

        // 3. Keep Firestore 'isOnline' check synchronized when the client is active
        userDocRef.update({
          'isOnline': true,
          'lastSeen': FieldValue.serverTimestamp(),
        });

        debugPrint('PresenceService: User $uid is Online');
      }
    });
  }

  /// Manually force status to offline (e.g. on logout)
  Future<void> setOffline(String uid) async {
    _cleanup();
    try {
      await _database.ref('presence/$uid').set(false);
      await _firestore.collection('users').doc(uid).update({
        'isOnline': false,
        'lastSeen': FieldValue.serverTimestamp(),
      });
      debugPrint('PresenceService: User $uid set to Offline');
    } catch (e) {
      debugPrint('PresenceService ERROR: $e');
    }
  }

  /// Get real-time presence stream for a specific user.
  /// Returns 'true' for online, 'false' for offline.
  Stream<bool> getPresenceStream(String uid) {
    return _database.ref('presence/$uid').onValue.map((event) {
      return event.snapshot.value as bool? ?? false;
    });
  }

  void _cleanup() {
    _connectionSubscription?.cancel();
    _connectionSubscription = null;
  }
}
