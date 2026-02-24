/// User role enumeration for role-based access control
enum UserRole {
  admin,
  regularUser;

  /// Convert role to string for storage
  String toJson() => name;

  /// Create role from string
  static UserRole fromJson(String json) {
    switch (json.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'regularuser':
      case 'regular_user':
        return UserRole.regularUser;
      default:
        return UserRole.regularUser;
    }
  }

  /// Get display name for role
  String get displayName {
    switch (this) {
      case UserRole.admin:
        return 'Administrator';
      case UserRole.regularUser:
        return 'Regular User';
    }
  }

  /// Check if role has admin privileges
  bool get isAdmin => this == UserRole.admin;

  /// Get role description
  String get description {
    switch (this) {
      case UserRole.admin:
        return 'Full system access including user management and emergency controls';
      case UserRole.regularUser:
        return 'Can view data and control pumps, but cannot manage users';
    }
  }
}
