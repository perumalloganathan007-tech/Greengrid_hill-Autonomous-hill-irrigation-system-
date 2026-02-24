import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing app preferences
class PreferencesService {
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyEsp32Url = 'esp32_url';
  static const String _keyNotifications = 'notifications_enabled';
  static const String _keyAutoMode = 'auto_mode_default';
  static const String _keyRefreshInterval = 'refresh_interval';
  static const String _keyFirstLaunch = 'first_launch';
  static const String _keyRememberMe = 'remember_me';
  
  SharedPreferences? _prefs;
  
  /// Initialize preferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  /// Check if this is first launch
  Future<bool> isFirstLaunch() async {
    await init();
    final isFirst = _prefs?.getBool(_keyFirstLaunch) ?? true;
    if (isFirst) {
      await _prefs?.setBool(_keyFirstLaunch, false);
    }
    return isFirst;
  }
  
  /// Theme mode (light/dark/system)
  Future<String> getThemeMode() async {
    await init();
    return _prefs?.getString(_keyThemeMode) ?? 'system';
  }
  
  Future<void> setThemeMode(String mode) async {
    await init();
    await _prefs?.setString(_keyThemeMode, mode);
  }
  
  /// ESP32 URL
  Future<String> getEsp32Url() async {
    await init();
    return _prefs?.getString(_keyEsp32Url) ?? 'http://192.168.1.100';
  }
  
  Future<void> setEsp32Url(String url) async {
    await init();
    await _prefs?.setString(_keyEsp32Url, url);
  }
  
  /// Firebase URL (hardcoded - no longer user configurable)
  Future<String> getFirebaseUrl() async {
    return 'https://greengrid-hill-default-rtdb.firebaseio.com/';
  }
  
  /// Notifications enabled
  Future<bool> getNotificationsEnabled() async {
    await init();
    return _prefs?.getBool(_keyNotifications) ?? true;
  }
  
  Future<void> setNotificationsEnabled(bool enabled) async {
    await init();
    await _prefs?.setBool(_keyNotifications, enabled);
  }
  
  /// Auto mode default
  Future<bool> getAutoModeDefault() async {
    await init();
    return _prefs?.getBool(_keyAutoMode) ?? true;
  }
  
  Future<void> setAutoModeDefault(bool enabled) async {
    await init();
    await _prefs?.setBool(_keyAutoMode, enabled);
  }
  
  /// Refresh interval
  Future<int> getRefreshInterval() async {
    await init();
    return _prefs?.getInt(_keyRefreshInterval) ?? 5;
  }
  
  Future<void> setRefreshInterval(int seconds) async {
    await init();
    await _prefs?.setInt(_keyRefreshInterval, seconds);
  }
  
  /// Remember me (auto-login)
  Future<bool> getRememberMe() async {
    await init();
    return _prefs?.getBool(_keyRememberMe) ?? false;
  }
  
  Future<void> setRememberMe(bool enabled) async {
    await init();
    await _prefs?.setBool(_keyRememberMe, enabled);
  }
  
  /// Clear all preferences
  Future<void> clearAll() async {
    await init();
    await _prefs?.clear();
  }
}
