import 'package:equatable/equatable.dart';

/// Base class for authentication events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to check initial auth state (auto-login)
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Event to sign in with email and password
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginRequested({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}

/// Event to sign up with email and password
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String displayName;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.displayName,
  });

  @override
  List<Object?> get props => [email, password, displayName];
}

/// Event to sign in with Google
class GoogleSignInRequested extends AuthEvent {
  const GoogleSignInRequested();
}

/// Event to sign out
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

/// Event to send password reset email
class PasswordResetRequested extends AuthEvent {
  final String email;

  const PasswordResetRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

/// Event to update display name
class UpdateDisplayNameRequested extends AuthEvent {
  final String displayName;

  const UpdateDisplayNameRequested({required this.displayName});

  @override
  List<Object?> get props => [displayName];
}

/// Event to update password
class UpdatePasswordRequested extends AuthEvent {
  final String newPassword;

  const UpdatePasswordRequested({required this.newPassword});

  @override
  List<Object?> get props => [newPassword];
}

/// Event for auto-login attempt
class AutoLoginRequested extends AuthEvent {
  const AutoLoginRequested();
}
