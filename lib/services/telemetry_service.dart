import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/sensor_data.dart';
import '../models/pump_status.dart';
import 'cache_service.dart';

/// Service for real-time telemetry data streaming from Firebase
class TelemetryService {
  FirebaseDatabase? _database;
  bool _useFirebase = false;
  final CacheService _cacheService = CacheService();
  final String userId;

  // StreamControllers for real-time data
  final _sensorDataController = StreamController<List<SensorData>>.broadcast();
  final _pumpStatusController = StreamController<List<PumpStatus>>.broadcast();

  // Database references
  DatabaseReference? _sensorsRef;
  DatabaseReference? _pumpsRef;

  // Subscriptions
  StreamSubscription? _sensorSubscription;
  StreamSubscription? _pumpSubscription;

  TelemetryService({required this.userId}) {
    try {
      _database = FirebaseDatabase.instance;
      _sensorsRef = _database!.ref('users/$userId/moisture_data'); // Corrected to match actual database structure
      _pumpsRef = _database!.ref('pumps');
      _useFirebase = true;
    } catch (e) {
      // Firebase not initialized, will use cache data
      _useFirebase = false;
    }
  }

  /// Stream of sensor data updates
  Stream<List<SensorData>> get sensorDataStream => _sensorDataController.stream;

  /// Stream of pump status updates
  Stream<List<PumpStatus>> get pumpStatusStream => _pumpStatusController.stream;

  /// Start listening to real-time sensor data
  void startSensorMonitoring() {
    if (!_useFirebase || _sensorsRef == null) {
      // Load cached data first
      _loadCachedSensors();
      return;
    }

    try {
      debugPrint('TelemetryService: Starting sensor monitor for users/$userId/moisture_data');
      // Listen to the user-specific moisture data directly
      _sensorSubscription = _sensorsRef!.onValue.listen((event) {
        final data = event.snapshot.value;
        if (data != null && data is String) {
          final sensors = _parseMoistureData(data);
          if (sensors.isNotEmpty) {
            _sensorDataController.add(sensors);
            _cacheService.cacheSensors(sensors);
          }
        }
      }, onError: (error) {
        debugPrint('TelemetryService ERROR (User Moisture Data): $error');
      });
    } catch (e) {
      debugPrint('TelemetryService: Exception during sensor monitor setup: $e');
    }
  }



  /// Parse moisture data from format "T1:12:30.5,T2:37:25.0" or "T1:12,T2:37"
  List<SensorData> _parseMoistureData(String data) {
    final List<SensorData> sensors = [];
    final parts = data.split(',');

    for (var part in parts) {
      final values = part.split(':');
      if (values.length >= 2) {
        // Tagged format "T1:45:25.5" (ID:Moisture:Temp)
        final sensorId = values[0].trim();
        final moisture = double.tryParse(values[1].trim()) ?? 0.0;
        double? temp;
        if (values.length >= 3) {
          temp = double.tryParse(values[2].trim());
        }

        sensors.add(
          SensorData.fromMoistureLevel(
            sensorId: sensorId,
            moistureLevel: moisture,
            location: 'Terrace Zone ${sensorId.replaceAll('T', '')}',
            temperature: temp,
          ),
        );
      } else if (values.length == 1 && values[0].trim().isNotEmpty) {
        // Single value format "45.5"
        final moisture = double.tryParse(values[0].trim());
        if (moisture != null) {
          sensors.add(
            SensorData.fromMoistureLevel(
              sensorId: 'T1',
              moistureLevel: moisture,
              location: 'Terrace Zone 1',
            ),
          );
        }
      }
    }

    return sensors;
  }

  /// Start listening to real-time pump/flow data
  void startPumpMonitoring() {
    if (!_useFirebase || _pumpsRef == null) {
      return;
    }

    try {
      _pumpSubscription = _pumpsRef!.onValue.listen((event) {
        final data = event.snapshot.value;
        if (data != null && data is Map) {
          final List<PumpStatus> pumps = [];
          data.forEach((key, value) {
            if (value is Map) {
              final mapValue = Map<String, dynamic>.from(value);
              mapValue['pumpId'] ??= key;
              pumps.add(PumpStatus.fromJson(mapValue));
            }
          });
          _pumpStatusController.add(pumps);
        }
      }, onError: (error) {
        debugPrint('TelemetryService ERROR (Pumps): $error');
      });
    } catch (e) {
      debugPrint('TelemetryService: Exception during pump monitor setup: $e');
    }
  }

  /// Get latest sensor reading
  Future<SensorData?> getLatestSensorData(String sensorId) async {
    if (!_useFirebase || _sensorsRef == null) return null;

    try {
      final snapshot = await _sensorsRef!.get();
      if (snapshot.exists && snapshot.value != null && snapshot.value is String) {
        final dataStr = snapshot.value as String;
        final sensors = _parseMoistureData(dataStr);
        try {
          return sensors.firstWhere((s) => s.sensorId == sensorId);
        } catch (_) {
          return null;
        }
      }
      return null;
    } catch (e) {
      debugPrint('TelemetryService: Error getting latest sensors: $e');
      return null;
    }
  }

  /// Stop all monitoring and close streams
  void dispose() {
    _sensorSubscription?.cancel();
    _pumpSubscription?.cancel();
    _sensorDataController.close();
    _pumpStatusController.close();
  }

  /// Load cached sensors for offline mode
  Future<void> _loadCachedSensors() async {
    final cached = await _cacheService.getCachedSensors();
    if (cached != null && cached.isNotEmpty) {
      _sensorDataController.add(cached);
    }
  }

  /// Check if cache is stale
  Future<bool> isCacheStale() async {
    return await _cacheService.isCacheStale();
  }
}
