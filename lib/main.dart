import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/screens/splash_screen.dart';
import 'utils/theme.dart';
import 'services/preferences_service.dart';

void main() async {
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
}

class GreenGridApp extends StatefulWidget {
  const GreenGridApp({super.key});

  @override
  State<GreenGridApp> createState() => _GreenGridAppState();
}

class _GreenGridAppState extends State<GreenGridApp> {
  ThemeMode _themeMode = ThemeMode.system;
  final PreferencesService _prefsService = PreferencesService();

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
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

  void _updateThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenGrid Hill',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: SplashScreen(onThemeChanged: _updateThemeMode),
    );
  }
}