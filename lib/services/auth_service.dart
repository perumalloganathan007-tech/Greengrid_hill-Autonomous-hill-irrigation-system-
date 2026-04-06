import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import '../models/user_role.dart';
import 'user_service.dart';
import 'presence_service.dart';

/// Service for Firebase Authentication operations
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserService _userService = UserService();
  final PresenceService _presenceService = PresenceService();

  /// Get current user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Get current Firebase user
  User? get currentUser => _auth.currentUser;

  /// Sign in with email and password
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Sign in failed');
      }

      // Update last login
      await _userService.updateLastLogin(credential.user!.uid);
      
      // Initialize real-time presence
      _presenceService.initialize(credential.user!.uid);

      // Get user profile
      final userProfile = await _userService.getUserProfile(
        credential.user!.uid,
      );
      return userProfile;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Sign up with email and password
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Sign up failed');
      }

      // Update display name
      await credential.user!.updateDisplayName(displayName);

      // Check if email matches hardcoded admins
      final bool isAdmin =
          email.toLowerCase() == 'perumalloganathan007@gmail.com' ||
          email.toLowerCase() == 'subikshan.mailbox@gmail.com';
      final role = isAdmin ? UserRole.admin : UserRole.regularUser;

      // Create user profile in Firestore
      final userModel = UserModel(
        uid: credential.user!.uid,
        email: email,
        displayName: displayName,
        role: role,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );

      await _userService.createUserProfile(userModel);
      
      // Initialize real-time presence
      _presenceService.initialize(credential.user!.uid);

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Sign in with Google
  Future<UserModel> signInWithGoogle() async {
    try {
      // Trigger the Google authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google sign-in was cancelled');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw Exception('Google sign-in failed');
      }

      final user = userCredential.user!;

      // Check if user profile exists in Firestore
      UserModel? existingProfile;
      try {
        existingProfile = await _userService.getUserProfile(user.uid);
        // Update last login
        await _userService.updateLastLogin(user.uid);
        
        // Initialize real-time presence
        _presenceService.initialize(user.uid);

        return existingProfile;
      } catch (e) {
        final String userEmail = user.email?.toLowerCase() ?? '';
        final bool isAdmin =
            userEmail == 'perumalloganathan007@gmail.com' ||
            userEmail == 'subikshan.mailbox@gmail.com';
        final role = isAdmin ? UserRole.admin : UserRole.regularUser;

        final userModel = UserModel(
          uid: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? googleUser.displayName ?? 'User',
          role: role,
          createdAt: DateTime.now(),
          lastLogin: DateTime.now(),
        );

        await _userService.createUserProfile(userModel);

        // Initialize real-time presence
        _presenceService.initialize(user.uid);

        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Google sign-in error: ${e.toString()}');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      if (_auth.currentUser != null) {
        await _presenceService.setOffline(_auth.currentUser!.uid);
      }
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Send password reset email
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Update display name
  Future<void> updateDisplayName(String displayName) async {
    try {
      await currentUser?.updateDisplayName(displayName);
      if (currentUser != null) {
        await _userService.updateUserProfile(currentUser!.uid, {
          'displayName': displayName,
        });
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Update password
  Future<void> updatePassword(String newPassword) async {
    try {
      await currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Get current user model
  Future<UserModel?> getCurrentUserModel() async {
    if (currentUser == null) return null;
    try {
      return await _userService.getUserProfile(currentUser!.uid);
    } catch (e) {
      return null;
    }
  }

  /// Check if current user is admin
  Future<bool> isAdmin() async {
    final userModel = await getCurrentUserModel();
    return userModel?.isAdmin ?? false;
  }

  /// Get user role
  Future<UserRole> getUserRole() async {
    final userModel = await getCurrentUserModel();
    return userModel?.role ?? UserRole.regularUser;
  }

  /// Handle Firebase Auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'network-request-failed':
        return 'Network error. Please check your connection';
      default:
        debugPrint('UNHANDLED FIREBASE AUTH ERROR: [${e.code}] ${e.message}');
        return 'Auth Error: [${e.code}] ${e.message}';
    }
  }
}
