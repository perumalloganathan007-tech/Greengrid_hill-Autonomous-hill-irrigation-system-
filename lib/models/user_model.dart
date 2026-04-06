import 'package:equatable/equatable.dart';
import 'user_role.dart';

/// User model for authentication and authorization
class UserModel extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final UserRole role;
  final DateTime createdAt;
  final DateTime lastLogin;
  final bool isActive;
  final bool isOnline;

  const UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    required this.createdAt,
    required this.lastLogin,
    this.isActive = true,
    this.isOnline = false,
  });

  /// Create user from Firestore document
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String? ?? '',
      role: UserRole.fromJson(json['role'] as String? ?? 'regularUser'),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLogin: DateTime.parse(json['lastLogin'] as String),
      isActive: json['isActive'] as bool? ?? true,
      isOnline: json['isOnline'] as bool? ?? false,
    );
  }

  /// Convert user to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': role.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
      'isActive': isActive,
      'isOnline': isOnline,
    };
  }

  /// Create copy with updated fields
  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    UserRole? role,
    DateTime? createdAt,
    DateTime? lastLogin,
    bool? isActive,
    bool? isOnline,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      isActive: isActive ?? this.isActive,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  /// Check if user is admin
  bool get isAdmin => role.isAdmin;

  /// Get user initials for avatar
  String get initials {
    if (displayName.isEmpty) {
      return email.substring(0, 1).toUpperCase();
    }
    final parts = displayName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return displayName.substring(0, 1).toUpperCase();
  }

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    role,
    createdAt,
    lastLogin,
    isActive,
    isOnline,
  ];
}
