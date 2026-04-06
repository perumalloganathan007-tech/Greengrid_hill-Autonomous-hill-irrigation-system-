import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/user_role.dart';

/// Service for Firestore user operations
class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _usersCollection = 'users';

  /// Create user profile in Firestore
  Future<void> createUserProfile(UserModel user) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(user.uid)
          .set(user.toJson())
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  /// Get user profile from Firestore
  Future<UserModel> getUserProfile(String uid) async {
    try {
      final doc = await _firestore
          .collection(_usersCollection)
          .doc(uid)
          .get()
          .timeout(const Duration(seconds: 5));

      if (!doc.exists) {
        throw Exception('User profile not found');
      }

      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  /// Update user profile
  Future<void> updateUserProfile(
    String uid,
    Map<String, dynamic> updates,
  ) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(uid)
          .update(updates)
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  /// Update last login timestamp
  Future<void> updateLastLogin(String uid) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(uid)
          .update({
            'lastLogin': DateTime.now().toIso8601String(),
            'isOnline': true,
          })
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      // Don't throw error if last login update fails
      debugPrint('Failed to update last login: $e');
    }
  }

  /// Update online status
  Future<void> updateOnlineStatus(String uid, bool isOnline) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(uid)
          .update({'isOnline': isOnline})
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      debugPrint('Failed to update online status: $e');
    }
  }

  /// Get all users (admin only)
  Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get users: $e');
    }
  }

  /// Update user role (admin only)
  Future<void> updateUserRole(String uid, UserRole role) async {
    try {
      await _firestore.collection(_usersCollection).doc(uid).update({
        'role': role.toJson(),
      });
    } catch (e) {
      throw Exception('Failed to update user role: $e');
    }
  }

  /// Delete user (admin only)
  Future<void> deleteUser(String uid) async {
    try {
      await _firestore.collection(_usersCollection).doc(uid).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  /// Toggle user active status
  Future<void> toggleUserStatus(String uid, bool isActive) async {
    try {
      await _firestore.collection(_usersCollection).doc(uid).update({
        'isActive': isActive,
      });
    } catch (e) {
      throw Exception('Failed to update user status: $e');
    }
  }

  /// Check if this is the first or second user (for auto-admin assignment)
  Future<bool> isFirstOrSecondUser() async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .limit(2)
          .get()
          .timeout(const Duration(seconds: 5));

      return querySnapshot.docs.length < 2;
    } catch (e) {
      // If there's an error, assume not first or second user
      return false;
    }
  }

  /// Get user count
  Future<int> getUserCount() async {
    try {
      final querySnapshot = await _firestore.collection(_usersCollection).get();
      return querySnapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }

  /// Get users stream (for real-time updates)
  Stream<List<UserModel>> getUsersStream() {
    return _firestore
        .collection(_usersCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => UserModel.fromJson(doc.data()))
              .toList(),
        );
  }

  /// Get single user stream (for real-time updates)
  Stream<UserModel> getUserStream(String uid) {
    return _firestore
        .collection(_usersCollection)
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        throw Exception('User not found');
      }
      return UserModel.fromJson(snapshot.data()!);
    });
  }

  /// Search users by email or display name
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .where('email', isGreaterThanOrEqualTo: query)
          .where('email', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }
}
