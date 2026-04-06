import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pump_status.dart';

/// Service for controlling pumps/solenoids with debounce protection
class ControlService {
  final String esp32BaseUrl; // e.g., "http://192.168.1.100"

  // Debounce timer to prevent rapid toggling
  Timer? _debounceTimer;
  static const Duration debounceDuration = Duration(seconds: 2);

  // Track last command sent
  DateTime? _lastCommandTime;

  ControlService({required this.esp32BaseUrl});

  /// Toggle pump with debounce protection
  Future<bool> togglePump({
    required String pumpId,
    required bool turnOn,
  }) async {
    // Debounce check
    if (_debounceTimer?.isActive ?? false) {
      debugPrint('Command ignored: Debounce active');
      return false;
    }

    // Prevent rapid toggling (safety mechanism)
    if (_lastCommandTime != null) {
      final timeSinceLastCommand = DateTime.now().difference(_lastCommandTime!);
      if (timeSinceLastCommand < debounceDuration) {
        debugPrint('Command ignored: Too soon since last command');
        return false;
      }
    }

    try {
      // Send HTTP POST request to ESP32
      final response = await http
          .post(
            Uri.parse('$esp32BaseUrl/api/pump/control'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'pumpId': pumpId,
              'action': turnOn ? 'on' : 'off',
              'timestamp': DateTime.now().toIso8601String(),
            }),
          )
          .timeout(const Duration(seconds: 5));

      _lastCommandTime = DateTime.now();

      // Set debounce timer
      _debounceTimer = Timer(debounceDuration, () {
        _debounceTimer = null;
      });

      if (response.statusCode == 200) {
        debugPrint('Pump ${turnOn ? "activated" : "deactivated"}: $pumpId');
        return true;
      } else {
        debugPrint('Failed to control pump: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error controlling pump: $e');
      return false;
    }
  }

  /// Set pump to auto mode
  Future<bool> setAutoMode(String pumpId) async {
    try {
      final response = await http
          .post(
            Uri.parse('$esp32BaseUrl/api/pump/mode'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'pumpId': pumpId, 'mode': 'auto'}),
          )
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Error setting auto mode: $e');
      return false;
    }
  }

  /// Set pump to manual mode
  Future<bool> setManualMode(String pumpId) async {
    try {
      final response = await http
          .post(
            Uri.parse('$esp32BaseUrl/api/pump/mode'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'pumpId': pumpId, 'mode': 'manual'}),
          )
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Error setting manual mode: $e');
      return false;
    }
  }

  /// Get current pump status from ESP32
  Future<PumpStatus?> getPumpStatus(String pumpId) async {
    try {
      final response = await http
          .get(Uri.parse('$esp32BaseUrl/api/pump/status/$pumpId'))
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PumpStatus.fromJson(data);
      }
      return null;
    } on TimeoutException {
      debugPrint('Timeout fetching pump status: $pumpId is unreachable.');
      return null;
    } catch (e) {
      debugPrint('Error fetching pump status: $e');
      return null;
    }
  }

  /// Emergency stop all pumps
  Future<bool> emergencyStopAll() async {
    try {
      final response = await http
          .post(
            Uri.parse('$esp32BaseUrl/api/emergency/stop'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } on TimeoutException {
      debugPrint('Timeout during emergency stop: ESP32 is unreachable.');
      return false;
    } catch (e) {
      debugPrint('Error during emergency stop: $e');
      return false;
    }
  }

  void dispose() {
    _debounceTimer?.cancel();
  }
}
