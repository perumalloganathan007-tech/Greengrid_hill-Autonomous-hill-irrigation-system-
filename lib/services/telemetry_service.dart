import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/sensor_data.dart';
import '../models/tank_level.dart';
import 'cache_service.dart';

/// Service for real-time telemetry data streaming from Firebase
class TelemetryService {
  FirebaseDatabase? _database;
  bool _useFirebase = false;
  final CacheService _cacheService = CacheService();
  final String userId;

  // StreamControllers for real-time data
  final _sensorDataController = StreamController<List<SensorData>>.broadcast();
  final _tankLevelController = StreamController<List<TankLevel>>.broadcast();

  // Database references
  DatabaseReference? _sensorsRef;
  DatabaseReference? _tanksRef;

  // Subscriptions
  StreamSubscription? _sensorSubscription;
  StreamSubscription? _tankSubscription;

  TelemetryService({required this.userId}) {
    try {
      _database = FirebaseDatabase.instance;
      _sensorsRef = _database!.ref('users/$userId/moisture_data'); // Aligned with user-specific structure
      _tanksRef = _database!.ref('tanks');
      _useFirebase = true;
    } catch (e) {
      // Firebase not initialized, will use cache data
      _useFirebase = false;
    }
  }

  /// Stream of sensor data updates
  Stream<List<SensorData>> get sensorDataStream => _sensorDataController.stream;

  /// Stream of tank level updates
  Stream<List<TankLevel>> get tankLevelStream => _tankLevelController.stream;

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



  /// Parse moisture data from format "T1:12,T2:37,T3:0"
  List<SensorData> _parseMoistureData(String data) {
    final List<SensorData> sensors = [];
    final parts = data.split(',');

    for (var part in parts) {
      final values = part.split(':');
      if (values.length == 2) {
        final sensorId = values[0].trim();
        final moisture = double.tryParse(values[1].trim()) ?? 0.0;

        sensors.add(
          SensorData.fromMoistureLevel(
            sensorId: sensorId,
            moistureLevel: moisture,
            location: 'Terrace Zone ${sensorId.replaceAll('T', '')}',
          ),
        );
      }
    }

    return sensors;
  }

  /// Start listening to real-time tank level data
  void startTankMonitoring() {
    if (!_useFirebase || _tanksRef == null) {
      // Load cached data first
      _loadCachedTanks();
      return;
    }

    try {
      _tankSubscription = _tanksRef!.onValue.listen((event) {
        final data = event.snapshot.value;
        if (data != null && data is Map) {
          final List<TankLevel> tanks = [];
          data.forEach((key, value) {
            if (value is Map) {
              final mapValue = Map<String, dynamic>.from(value);
              mapValue['tankId'] ??= key;
              mapValue['timestamp'] ??= DateTime.now().toIso8601String();
              // Removed default value assignments as they should be handled by the model or data source
              tanks.add(TankLevel.fromJson(mapValue));
            }
          });
          _tankLevelController.add(tanks);
          // Cache for offline use
          _cacheService.cacheTanks(tanks);
        }
      }, onError: (error) {
        debugPrint('TelemetryService ERROR (Tanks): $error');
      });
    } catch (e) {
      debugPrint('TelemetryService: Exception during tank monitor setup: $e');
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

  /// Get latest tank level
  Future<TankLevel?> getLatestTankLevel(String tankId) async {
    if (!_useFirebase || _tanksRef == null) return null;

    try {
      final snapshot = await _tanksRef!.child(tankId).get();
      if (snapshot.exists && snapshot.value != null) {
        return TankLevel.fromJson(
          Map<String, dynamic>.from(snapshot.value as Map),
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Stop all monitoring and close streams
  void dispose() {
    _sensorSubscription?.cancel();
    _tankSubscription?.cancel();
    _sensorDataController.close();
    _tankLevelController.close();
  }

  /// Load cached sensors for offline mode
  Future<void> _loadCachedSensors() async {
    final cached = await _cacheService.getCachedSensors();
    if (cached != null && cached.isNotEmpty) {
      _sensorDataController.add(cached);
    }
  }

  /// Load cached tanks for offline mode
  Future<void> _loadCachedTanks() async {
    final cached = await _cacheService.getCachedTanks();
    if (cached != null && cached.isNotEmpty) {
      _tankLevelController.add(cached);
    }
  }

  /// Check if cache is stale
  Future<bool> isCacheStale() async {
    return await _cacheService.isCacheStale();
  }
}
