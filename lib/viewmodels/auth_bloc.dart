import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../services/auth_service.dart';
import '../services/audit_service.dart';
import '../services/preferences_service.dart';

/// BLoC for handling authentication state and events
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final AuditService _auditService;
  final PreferencesService _preferencesService;

  AuthBloc({
    required AuthService authService,
    required AuditService auditService,
    required PreferencesService preferencesService,
  })  : _authService = authService,
        _auditService = auditService,
        _preferencesService = preferencesService,
        super(const AuthInitial()) {
    // Register event handlers
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<PasswordResetRequested>(_onPasswordResetRequested);
    on<UpdateDisplayNameRequested>(_onUpdateDisplayNameRequested);
    on<UpdatePasswordRequested>(_onUpdatePasswordRequested);
    on<AutoLoginRequested>(_onAutoLoginRequested);
  }

  /// Check current authentication status
  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final userModel = await _authService.getCurrentUserModel();
      
      if (userModel != null) {
        emit(Authenticated(user: userModel));
      } else {
        emit(const Unauthenticated());
      }
    } catch (e) {
      emit(const Unauthenticated());
    }
  }

  /// Handle login request
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      final user = await _authService.signIn(
        email: event.email,
        password: event.password,
      );

      // Save remember me preference
      await _preferencesService.setRememberMe(event.rememberMe);

      // Log the login
      await _auditService.logLogin();

      emit(Authenticated(user: user));
    } catch (e) {
      emit(AuthError(
        message: e.toString(),
        isUnauthenticated: true,
      ));
    }
  }

  /// Handle sign up request
  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      final user = await _authService.signUp(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
      );

      // Log the sign up
      await _auditService.logAction(
        action: 'User Registration',
        category: 'authentication',
        details: 'New user account created',
      );

      emit(Authenticated(user: user));
    } catch (e) {
      emit(AuthError(
        message: e.toString(),
        isUnauthenticated: true,
      ));
    }
  }

  /// Handle Google sign-in request
  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      final user = await _authService.signInWithGoogle();

      // Log the login
      await _auditService.logLogin();

      emit(Authenticated(user: user));
    } catch (e) {
      emit(AuthError(
        message: e.toString(),
        isUnauthenticated: true,
      ));
    }
  }

  /// Handle logout request
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      // Log the logout
      await _auditService.logLogout();

      await _authService.signOut();

      // Clear remember me preference
      await _preferencesService.setRememberMe(false);

      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  /// Handle password reset request
  Future<void> _onPasswordResetRequested(
    PasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      await _authService.resetPassword(event.email);

      emit(PasswordResetSent(email: event.email));
      
      // Return to unauthenticated state after a delay
      await Future.delayed(const Duration(seconds: 3));
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(
        message: e.toString(),
        isUnauthenticated: true,
      ));
    }
  }

  /// Handle update display name request
  Future<void> _onUpdateDisplayNameRequested(
    UpdateDisplayNameRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state is! Authenticated) return;

      emit(const AuthLoading());

      await _authService.updateDisplayName(event.displayName);

      // Log the change
      await _auditService.logSettingsChange(
        setting: 'displayName',
        oldValue: (state as Authenticated).user.displayName,
        newValue: event.displayName,
      );

      // Get updated user model
      final updatedUser = await _authService.getCurrentUserModel();
      
      if (updatedUser != null) {
        emit(ProfileUpdated(
          user: updatedUser,
          message: 'Display name updated successfully',
        ));
        
        // Return to authenticated state
        await Future.delayed(const Duration(seconds: 2));
        emit(Authenticated(user: updatedUser));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  /// Handle update password request
  Future<void> _onUpdatePasswordRequested(
    UpdatePasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state is! Authenticated) return;

      emit(const AuthLoading());

      await _authService.updatePassword(event.newPassword);

      // Log the change
      await _auditService.logAction(
        action: 'Password Changed',
        category: 'security',
        details: 'User password updated',
      );

      final currentUser = (state as Authenticated).user;
      
      emit(ProfileUpdated(
        user: currentUser,
        message: 'Password updated successfully',
      ));
      
      // Return to authenticated state
      await Future.delayed(const Duration(seconds: 2));
      emit(Authenticated(user: currentUser));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  /// Handle auto-login request (remember me)
  Future<void> _onAutoLoginRequested(
    AutoLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      // Check if remember me is enabled
      final rememberMe = await _preferencesService.getRememberMe();
      
      if (!rememberMe) {
        emit(const Unauthenticated());
        return;
      }

      // Check if user is already authenticated
      final userModel = await _authService.getCurrentUserModel();
      
      if (userModel != null) {
        emit(Authenticated(user: userModel));
      } else {
        emit(const Unauthenticated());
      }
    } catch (e) {
      emit(const Unauthenticated());
    }
  }
}
