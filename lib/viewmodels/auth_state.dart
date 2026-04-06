import 'package:equatable/equatable.dart';
import '../models/user_model.dart';

/// Base class for authentication states
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state before auth check
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state during authentication operations
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Authenticated state with user data
class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

/// Unauthenticated state
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// Error state with message
class AuthError extends AuthState {
  final String message;
  final bool isUnauthenticated;

  const AuthError({required this.message, this.isUnauthenticated = false});

  @override
  List<Object?> get props => [message, isUnauthenticated];
}

/// Password reset email sent
class PasswordResetSent extends AuthState {
  final String email;

  const PasswordResetSent({required this.email});

  @override
  List<Object?> get props => [email];
}

/// Profile updated successfully
class ProfileUpdated extends AuthState {
  final UserModel user;
  final String message;

  const ProfileUpdated({required this.user, required this.message});

  @override
  List<Object?> get props => [user, message];
}
