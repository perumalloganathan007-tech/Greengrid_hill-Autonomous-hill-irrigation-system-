import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/sensor_data.dart';

/// Service for managing push notifications and alerts
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  // Notification thresholds
  static const double criticalMoistureThreshold = 15.0;
  static const double warningMoistureThreshold = 30.0;

  /// Initialize notification service
  Future<void> initialize() async {
    if (_isInitialized) return;

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    try {
      await _notifications.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );
      _isInitialized = true;

      // Request permissions for iOS
      await _requestPermissions();
    } catch (e) {
      // Notification service not available (e.g., on web)
      _isInitialized = false;
    }
  }

  Future<void> _requestPermissions() async {
    await _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap - navigate to relevant screen
    // This would be implemented with navigation logic
  }

  /// Check sensor data and send alerts if thresholds breached
  Future<void> checkSensorAlerts(List<SensorData> sensors) async {
    if (!_isInitialized) return;

    for (final sensor in sensors) {
      if (sensor.moistureLevel <= criticalMoistureThreshold) {
        await _showNotification(
          id: sensor.sensorId.hashCode,
          title: '🚨 Critical Moisture Alert',
          body:
              '${sensor.location}: ${sensor.moistureLevel.toStringAsFixed(1)}% - Immediate irrigation needed!',
          priority: Priority.max,
        );
      } else if (sensor.moistureLevel <= warningMoistureThreshold) {
        await _showNotification(
          id: sensor.sensorId.hashCode,
          title: '⚠️ Low Moisture Warning',
          body:
              '${sensor.location}: ${sensor.moistureLevel.toStringAsFixed(1)}% - Consider watering soon',
          priority: Priority.high,
        );
      }
    }
  }

  /// Send automated irrigation started alert
  Future<void> notifyIrrigationStarted(String zone, double moisture) async {
    if (!_isInitialized) return;

    await _showNotification(
      id: zone.hashCode,
      title: '💧 Irrigation Started (Auto)',
      body: '$zone: Moisture is ${moisture.toStringAsFixed(1)}% (Threshold 30%). Smart watering active.',
      priority: Priority.high,
    );
  }

  /// Check pump failure and send alerts
  Future<void> sendPumpFailureAlert(String pumpId, String zone) async {
    if (!_isInitialized) return;

    await _showNotification(
      id: pumpId.hashCode,
      title: '❌ Valve Control Failed',
      body: 'Failed to control ${pumpId.toLowerCase().replaceAll('pump_', 'Valve ').replaceAll('pump', 'Valve ')} in $zone - Check connection',
      priority: Priority.max,
    );
  }

  /// Send connection lost alert
  Future<void> sendConnectionLostAlert() async {
    if (!_isInitialized) return;

    await _showNotification(
      id: 9999,
      title: '📡 Connection Lost',
      body: 'Unable to reach ESP32 - Using cached data',
      priority: Priority.high,
    );
  }

  /// Send connection restored alert
  Future<void> sendConnectionRestoredAlert() async {
    if (!_isInitialized) return;

    await _showNotification(
      id: 9998,
      title: '✅ Connection Restored',
      body: 'Successfully reconnected to ESP32',
      priority: Priority.low,
    );
  }

  Future<void> _showNotification({
    required int id,
    required String title,
    required String body,
    Priority priority = Priority.defaultPriority,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'greengrid_alerts',
      'Irrigation Alerts',
      channelDescription: 'Critical alerts for irrigation management',
      importance: _getImportance(priority),
      priority: priority,
      icon: '@mipmap/ic_launcher',
      enableVibration: priority == Priority.max,
      playSound: priority == Priority.max || priority == Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(id: id, title: title, body: body, notificationDetails: details);
  }

  Importance _getImportance(Priority priority) {
    switch (priority) {
      case Priority.max:
        return Importance.max;
      case Priority.high:
        return Importance.high;
      case Priority.low:
        return Importance.low;
      default:
        return Importance.defaultImportance;
    }
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    if (!_isInitialized) return;
    await _notifications.cancelAll();
  }

  /// Cancel specific notification
  Future<void> cancel(int id) async {
    if (!_isInitialized) return;
    await _notifications.cancel(id: id);
  }
}
