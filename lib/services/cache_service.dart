import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sensor_data.dart';
import '../models/tank_level.dart';
import '../models/pump_status.dart';

/// Service for caching telemetry data for offline mode
class CacheService {
  static const String _sensorCacheKey = 'cached_sensors';
  static const String _tankCacheKey = 'cached_tanks';
  static const String _pumpCacheKey = 'cached_pumps';
  static const String _lastUpdateKey = 'last_cache_update';
  static const String _pendingCommandsKey = 'pending_commands';

  /// Cache sensor data
  Future<void> cacheSensors(List<SensorData> sensors) async {
    final prefs = await SharedPreferences.getInstance();
    final sensorMaps = sensors.map((s) => {
      'sensorId': s.sensorId,
      'moistureLevel': s.moistureLevel,
      'timestamp': s.timestamp.toIso8601String(),
      'status': s.status,
      'location': s.location,
    }).toList();
    
    await prefs.setString(_sensorCacheKey, jsonEncode(sensorMaps));
    await _updateCacheTimestamp();
  }

  /// Cache tank data
  Future<void> cacheTanks(List<TankLevel> tanks) async {
    final prefs = await SharedPreferences.getInstance();
    final tankMaps = tanks.map((t) => {
      'tankId': t.tankId,
      'levelPercentage': t.levelPercentage,
      'volumeLiters': t.volumeLiters,
      'capacityLiters': t.capacityLiters,
      'timestamp': t.timestamp.toIso8601String(),
      'status': t.status,
    }).toList();
    
    await prefs.setString(_tankCacheKey, jsonEncode(tankMaps));
    await _updateCacheTimestamp();
  }

  /// Cache pump status
  Future<void> cachePumps(List<PumpStatus> pumps) async {
    final prefs = await SharedPreferences.getInstance();
    final pumpMaps = pumps.map((p) => {
      'pumpId': p.pumpId,
      'isActive': p.isActive,
      'flowRate': p.flowRate,
      'pressure': p.pressure,
      'lastToggled': p.lastToggled.toIso8601String(),
      'controlMode': p.controlMode,
      'zone': p.zone,
    }).toList();
    
    await prefs.setString(_pumpCacheKey, jsonEncode(pumpMaps));
    await _updateCacheTimestamp();
  }

  /// Get cached sensors
  Future<List<SensorData>?> getCachedSensors() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_sensorCacheKey);
    if (cached == null) return null;

    try {
      final List<dynamic> decoded = jsonDecode(cached);
      return decoded.map((map) => SensorData(
        sensorId: map['sensorId'],
        moistureLevel: map['moistureLevel'],
        timestamp: DateTime.parse(map['timestamp']),
        status: map['status'],
        location: map['location'],
      )).toList();
    } catch (e) {
      return null;
    }
  }

  /// Get cached tanks
  Future<List<TankLevel>?> getCachedTanks() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_tankCacheKey);
    if (cached == null) return null;

    try {
      final List<dynamic> decoded = jsonDecode(cached);
      return decoded.map((map) => TankLevel(
        tankId: map['tankId'],
        levelPercentage: map['levelPercentage'],
        volumeLiters: map['volumeLiters'],
        capacityLiters: map['capacityLiters'],
        timestamp: DateTime.parse(map['timestamp']),
        status: map['status'],
      )).toList();
    } catch (e) {
      return null;
    }
  }

  /// Get cached pumps
  Future<List<PumpStatus>?> getCachedPumps() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_pumpCacheKey);
    if (cached == null) return null;

    try {
      final List<dynamic> decoded = jsonDecode(cached);
      return decoded.map((map) => PumpStatus(
        pumpId: map['pumpId'],
        isActive: map['isActive'],
        flowRate: map['flowRate'],
        pressure: map['pressure'],
        lastToggled: DateTime.parse(map['lastToggled']),
        controlMode: map['controlMode'],
        zone: map['zone'],
      )).toList();
    } catch (e) {
      return null;
    }
  }

  /// Get last cache update time
  Future<DateTime?> getLastCacheUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getString(_lastUpdateKey);
    if (timestamp == null) return null;
    return DateTime.parse(timestamp);
  }

  /// Queue a pump command for retry when online
  Future<void> queuePumpCommand(String pumpId, bool turnOn) async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_pendingCommandsKey) ?? '[]';
    final List<dynamic> commands = jsonDecode(cached);
    
    commands.add({
      'pumpId': pumpId,
      'turnOn': turnOn,
      'timestamp': DateTime.now().toIso8601String(),
    });
    
    await prefs.setString(_pendingCommandsKey, jsonEncode(commands));
  }

  /// Get pending commands
  Future<List<Map<String, dynamic>>> getPendingCommands() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_pendingCommandsKey) ?? '[]';
    final List<dynamic> decoded = jsonDecode(cached);
    return decoded.cast<Map<String, dynamic>>();
  }

  /// Clear pending commands
  Future<void> clearPendingCommands() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_pendingCommandsKey, '[]');
  }

  /// Check if cached data is stale (older than threshold)
  Future<bool> isCacheStale({Duration threshold = const Duration(minutes: 5)}) async {
    final lastUpdate = await getLastCacheUpdate();
    if (lastUpdate == null) return true;
    return DateTime.now().difference(lastUpdate) > threshold;
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sensorCacheKey);
    await prefs.remove(_tankCacheKey);
    await prefs.remove(_pumpCacheKey);
    await prefs.remove(_lastUpdateKey);
  }

  Future<void> _updateCacheTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastUpdateKey, DateTime.now().toIso8601String());
  }
}
