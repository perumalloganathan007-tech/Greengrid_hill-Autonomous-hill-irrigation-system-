/// Application-wide constants
class AppConstants {
  // App Information
  static const String appName = 'GreenGrid Hill';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Autonomous Hillside Irrigation System';
  
  // Network Configuration
  static const String defaultEsp32Url = 'http://192.168.1.100';
  static const String firebaseDatabaseUrl = 'https://greengrid-hill-default-rtdb.firebaseio.com/';
  static const Duration networkTimeout = Duration(seconds: 5);
  
  // Debounce Settings
  static const Duration debounceDuration = Duration(seconds: 2);
  
  // Refresh Intervals
  static const int minRefreshInterval = 1; // seconds
  static const int maxRefreshInterval = 30; // seconds
  static const int defaultRefreshInterval = 5; // seconds
  
  // Moisture Thresholds
  static const double criticalMoistureLevel = 20.0;
  static const double warningMoistureLevel = 40.0;
  static const double safeMoistureLevel = 40.0;
  
  // Tank Thresholds
  static const double tankFullLevel = 80.0;
  static const double tankNormalLevel = 30.0;
  static const double tankLowLevel = 15.0;
  
  // Sensor IDs
  static const List<String> sensorIds = [
    'sensor_zone_a',
    'sensor_zone_b',
    'sensor_zone_c',
    'sensor_zone_d',
  ];
  
  // Tank IDs
  static const List<String> tankIds = [
    'main_tank',
    'reserve_tank',
  ];
  
  // Pump IDs
  static const List<String> pumpIds = [
    'pump_1',
    'pump_2',
  ];
  
  // SharedPreferences Keys
  static const String prefKeyEsp32Url = 'esp32_url';
  static const String prefKeyNotifications = 'notifications';
  static const String prefKeyAutoMode = 'auto_mode';
  static const String prefKeyRefreshInterval = 'refresh_interval';
  
  // Firebase Paths
  static const String firebaseSensorsPath = 'terrace';
  static const String firebaseTanksPath = 'tanks';
  static const String firebaseAnalyticsPath = 'analytics/water_usage';
  static const String firebasePumpsPath = 'pumps';
  static const String firebaseAuditLogsPath = 'audit_logs';
  static const String firestoreUsersCollection = 'users';
  
  // Authentication
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;
  static const int minDisplayNameLength = 2;
  static const int maxDisplayNameLength = 50;
  static const Duration sessionTimeout = Duration(hours: 24);
  static const Duration rememberMeDuration = Duration(days: 30);
  
  // ESP32 API Endpoints
  static const String apiPumpControl = '/api/pump/control';
  static const String apiPumpMode = '/api/pump/mode';
  static const String apiPumpStatus = '/api/pump/status';
  static const String apiEmergencyStop = '/api/emergency/stop';
  
  // Chart Settings
  static const int maxChartDataPoints = 30;
  static const int weeklyDataDays = 7;
  static const int monthlyDataDays = 30;
  
  // Colors (as hex strings for consistency)
  static const int colorCritical = 0xFFF44336;
  static const int colorWarning = 0xFFFF9800;
  static const int colorSafe = 0xFF4CAF50;
  static const int colorNormal = 0xFF2196F3;
  
  // Error Messages
  static const String errorNoConnection = 'Unable to connect to ESP32';
  static const String errorFirebaseFailed = 'Firebase operation failed';
  static const String errorTimeout = 'Request timed out';
  static const String errorInvalidData = 'Invalid data received';
  
  // Success Messages
  static const String successPumpActivated = 'Pump activated successfully';
  static const String successPumpDeactivated = 'Pump deactivated successfully';
  static const String successSettingsSaved = 'Settings saved successfully';
  static const String successModeChanged = 'Control mode changed';
}
