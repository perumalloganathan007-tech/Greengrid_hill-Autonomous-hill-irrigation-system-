import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/sensor_data.dart';
import '../models/plant_profile.dart';
import '../models/terrace_data.dart';
import 'control_service.dart';
import 'notification_service.dart';

class SmartIrrigationService {
  final ControlService _controlService;
  final NotificationService _notificationService;

  // Track active irrigation tasks to handle cascade logic
  // Map of zone/terrace name to boolean
  final Map<String, bool> _activeIrrigations = {};

  SmartIrrigationService(this._controlService, this._notificationService);

  /// Analyzes the environment and evaluates the Water Needed based on:
  /// Water Needed = f(Plant Type + Soil Moisture + Temperature + Terrace Level)
  Future<void> evaluateAndTrigger({
    required SensorData sensorData,
    required PlantProfile plantProfile,
    required TerraceData terrace,
    required String pumpId,
  }) async {
    // If an upper terrace is currently being irrigated, we might want to delay
    // checking this lower terrace (Cascade Logic).
    if (terrace.terraceLevel > 1) {
      final upperTerraceZone = 'Terrace Zone ${terrace.terraceLevel - 1}';
      if (_activeIrrigations[upperTerraceZone] == true) {
        debugPrint('Cascade Rule: Upper terrace is irrigating. Waiting for water flow to reach ${terrace.zoneName}...');
        // In a full background isolate this would be an actual delay/retry loop.
        // For demonstration, we'll just return and let the next telemetry polling cycle retry.
        return;
      }
    }

    if (sensorData.moistureLevel < plantProfile.minMoisture) {
      // Needs water
      int baseDurationSeconds = plantProfile.baseWaterDuration.inSeconds;

      // Adjust based on terrace level
      if (terrace.terraceLevel == 1) {
        // Apply LOW water (slow drip)
        // Keep base duration, maybe reduce flow rate if pump supports it, 
        // or just apply base duration.
      } else {
        // Reduce water based on terrace level (gravity flow provides excess)
        baseDurationSeconds = (baseDurationSeconds * (1.0 - (terrace.terraceLevel * 0.15))).toInt();
      }

      // Adjust based on temperature
      if (sensorData.temperature != null) {
        if (sensorData.temperature! > 30.0) {
          // Increase water slightly (20% increase)
          baseDurationSeconds = (baseDurationSeconds * 1.2).toInt();
        } else if (sensorData.temperature! < 20.0) {
          // Reduce water (20% decrease)
          baseDurationSeconds = (baseDurationSeconds * 0.8).toInt();
        }
      }

      if (baseDurationSeconds < 10) baseDurationSeconds = 10; // Minimum threshold

      // Start Irrigation
      debugPrint('Triggering irrigation for ${terrace.zoneName} for $baseDurationSeconds seconds.');
      
      _activeIrrigations[terrace.zoneName] = true;
      final success = await _controlService.togglePump(pumpId: pumpId, turnOn: true);

      if (success) {
        // Notify the user
        _notificationService.notifyIrrigationStarted(terrace.zoneName, sensorData.moistureLevel);

        // Auto-turn off logic after duration
        Timer(Duration(seconds: baseDurationSeconds), () async {
          await _controlService.togglePump(pumpId: pumpId, turnOn: false);
          _activeIrrigations[terrace.zoneName] = false;
          debugPrint('Stopped irrigation for ${terrace.zoneName} after completing duration.');
        });
      } else {
        _activeIrrigations[terrace.zoneName] = false;
      }

    } else if (sensorData.moistureLevel >= plantProfile.maxMoisture) {
      // Stop irrigation
      if (_activeIrrigations[terrace.zoneName] == true) {
        debugPrint('Moisture sufficient. Stopping irrigation for ${terrace.zoneName}.');
        await _controlService.togglePump(pumpId: pumpId, turnOn: false);
        _activeIrrigations[terrace.zoneName] = false;
      }
    }
  }
}
