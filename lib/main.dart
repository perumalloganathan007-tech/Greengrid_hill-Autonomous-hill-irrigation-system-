import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'utils/theme.dart';
import 'services/preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/screens/auth_wrapper.dart';
import 'services/auth_service.dart';
import 'services/audit_service.dart';
import 'viewmodels/auth_bloc.dart';
import 'viewmodels/auth_event.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize preferences
    final prefsService = PreferencesService();
    await prefsService.init();

    // Check if first launch
    final isFirstLaunch = await prefsService.isFirstLaunch();
    if (isFirstLaunch) {
      // Set default preferences on first launch
      await prefsService.setThemeMode('system');
      await prefsService.setNotificationsEnabled(true);
      await prefsService.setAutoModeDefault(true);
      await prefsService.setRefreshInterval(5);
    }

    // === FIREBASE SETUP ===
    // Firebase is now enabled and configured!

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(const GreenGridApp());
  } catch (e, st) {
    debugPrint('INITIALIZATION ERROR CAUGHT: $e');
    debugPrint(st.toString());
  }
}

class GreenGridApp extends StatefulWidget {
  const GreenGridApp({super.key});

  @override
  State<GreenGridApp> createState() => _GreenGridAppState();
}

class _GreenGridAppState extends State<GreenGridApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;
  final PreferencesService _prefsService = PreferencesService();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    await _loadThemeMode();
    await _loadLocale();
  }

  Future<void> _loadThemeMode() async {
    final mode = await _prefsService.getThemeMode();
    setState(() {
      _themeMode = mode == 'light'
          ? ThemeMode.light
          : mode == 'dark'
          ? ThemeMode.dark
          : ThemeMode.system;
    });
  }

  Future<void> _loadLocale() async {
    final languageCode = await _prefsService.getLanguage();
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  void _updateThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  void _updateLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthService>(create: (context) => AuthService()),
        RepositoryProvider<AuditService>(create: (context) => AuditService()),
        RepositoryProvider<PreferencesService>.value(value: _prefsService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authService: RepositoryProvider.of<AuthService>(context),
              auditService: RepositoryProvider.of<AuditService>(context),
              preferencesService: RepositoryProvider.of<PreferencesService>(
                context,
              ),
            )..add(const AuthCheckRequested()),
          ),
        ],
        child: MaterialApp(
          title: 'GreenGrid Hill',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeMode,
          locale: _locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('hi'), // Hindi
            Locale('ta'), // Tamil
            Locale('te'), // Telugu
            Locale('ml'), // Malayalam
          ],
          home: AuthWrapper(
            onThemeChanged: _updateThemeMode,
            onLocaleChanged: _updateLocale,
          ),
        ),
      ),
    );
  }
}
