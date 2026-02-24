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
      await _firestore.collection(_usersCollection).doc(user.uid).set(user.toJson());
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  /// Get user profile from Firestore
  Future<UserModel> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection(_usersCollection).doc(uid).get();
      
      if (!doc.exists) {
        throw Exception('User profile not found');
      }

      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  /// Update user profile
  Future<void> updateUserProfile(String uid, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection(_usersCollection).doc(uid).update(updates);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  /// Update last login timestamp
  Future<void> updateLastLogin(String uid) async {
    try {
      await _firestore.collection(_usersCollection).doc(uid).update({
        'lastLogin': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Don't throw error if last login update fails
      print('Failed to update last login: $e');
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

  /// Check if this is the first user (for auto-admin assignment)
  Future<bool> isFirstUser() async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .limit(1)
          .get();

      return querySnapshot.docs.isEmpty;
    } catch (e) {
      // If there's an error, assume not first user
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
        .map((snapshot) => snapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .toList());
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
