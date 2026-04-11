// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get dashboard => 'Dashboard';

  @override
  String get analytics => 'Analytics';

  @override
  String get settings => 'Settings';

  @override
  String get profile => 'Profile';

  @override
  String get soilMoistureSensors => 'Soil Moisture Sensors';

  @override
  String get valveControls => 'Valve Controls';

  @override
  String get auto => 'Auto';

  @override
  String get manual => 'Manual';

  @override
  String get statusAutomatic => 'STATUS: AUTOMATIC';

  @override
  String get statusManualOn => 'STATUS: MANUAL (ON)';

  @override
  String get statusSystemOff => 'STATUS: SYSTEM OFF';

  @override
  String get lastSync => 'LAST SYNC';

  @override
  String get noSensorsFound => 'Data is not initialized or no sensors found.';

  @override
  String get noValvesAvailable => 'No valves available.';

  @override
  String get valveActivated => 'Valve activated';

  @override
  String get valveDeactivated => 'Valve deactivated';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get signIn => 'Sign In';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get waterUsageAnalytics => 'Water Usage Analytics';

  @override
  String get today => 'Today';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get waterUsed => 'Water Used';

  @override
  String get waterSaved => 'Water Saved';

  @override
  String get efficiency => 'Efficiency';

  @override
  String get usageTrend => 'Usage Trend';

  @override
  String get realTimeFlowMonitoring => 'Real-time Flow Monitoring';

  @override
  String get usageAnalysis => 'Usage Analysis';

  @override
  String get waterConservation => 'Water Conservation';

  @override
  String get irrigationActivity => 'Irrigation Activity';

  @override
  String get hardwareConnection => 'Hardware Connection';

  @override
  String get esp32IpAddress => 'ESP32 IP Address';

  @override
  String get appPreferences => 'App Preferences';

  @override
  String get enableNotifications => 'Enable Notifications';

  @override
  String get autoModeByDefault => 'Auto Mode by Default';

  @override
  String get dataRefresh => 'Data Refresh';

  @override
  String get refreshInterval => 'Refresh Interval';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get language => 'Language';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get testConnection => 'Test Connection';

  @override
  String get save => 'Save';

  @override
  String get settingsSaved => 'Settings saved successfully';

  @override
  String get statusSafe => 'SAFE';

  @override
  String get statusWarning => 'WARNING';

  @override
  String get statusCritical => 'CRITICAL';

  @override
  String get autoMode => 'Auto';

  @override
  String get manualMode => 'Manual';

  @override
  String setMode(String zone, String mode) {
    return '$zone set to $mode mode';
  }
}
