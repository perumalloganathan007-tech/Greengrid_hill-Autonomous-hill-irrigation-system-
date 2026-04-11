import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_screen.dart';
import '../../viewmodels/auth_bloc.dart';
import '../../viewmodels/auth_state.dart';
import 'login_screen.dart';
import 'main_navigation.dart';

class AuthWrapper extends StatelessWidget {
  final Function(ThemeMode)? onThemeChanged;
  final Function(Locale)? onLocaleChanged;

  const AuthWrapper({super.key, this.onThemeChanged, this.onLocaleChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return MainNavigation(
            onThemeChanged: onThemeChanged,
            onLocaleChanged: onLocaleChanged,
            user: state.user,
          );
        } else if (state is Unauthenticated) {
          return const LoginScreen();
        } else if (state is AuthInitial || state is AuthLoading) {
          return SplashScreen(
            onThemeChanged: onThemeChanged,
            onLocaleChanged: onLocaleChanged,
          );
        } else if (state is AuthError) {
          return const LoginScreen(); // Fallback to login on error
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
