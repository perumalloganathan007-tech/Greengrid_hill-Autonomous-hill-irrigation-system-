import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/irrigation_schedule.dart';
import '../models/sensor_data.dart';
import '../models/tank_level.dart';
import 'control_service.dart';
import 'cache_service.dart';

/// Service for managing irrigation schedules
class SchedulerService {
  static const String _schedulesKey = 'irrigation_schedules';
  final ControlService _controlService;
  Timer? _schedulerTimer;
  final _scheduleUpdateController =
      StreamController<List<IrrigationSchedule>>.broadcast();

  SchedulerService(this._controlService);

  Stream<List<IrrigationSchedule>> get scheduleUpdates =>
      _scheduleUpdateController.stream;

  /// Initialize scheduler and start checking schedules
  Future<void> initialize() async {
    // Check schedules every minute
    _schedulerTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkSchedules();
    });
  }

  /// Get all schedules
  Future<List<IrrigationSchedule>> getSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_schedulesKey);
    if (cached == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(cached);
      return decoded.map((json) => IrrigationSchedule.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Add new schedule
  Future<void> addSchedule(IrrigationSchedule schedule) async {
    final schedules = await getSchedules();
    schedules.add(schedule);
    await _saveSchedules(schedules);
    _scheduleUpdateController.add(schedules);
  }

  /// Update existing schedule
  Future<void> updateSchedule(IrrigationSchedule schedule) async {
    final schedules = await getSchedules();
    final index = schedules.indexWhere(
      (s) => s.scheduleId == schedule.scheduleId,
    );
    if (index != -1) {
      schedules[index] = schedule;
      await _saveSchedules(schedules);
      _scheduleUpdateController.add(schedules);
    }
  }

  /// Delete schedule
  Future<void> deleteSchedule(String scheduleId) async {
    final schedules = await getSchedules();
    schedules.removeWhere((s) => s.scheduleId == scheduleId);
    await _saveSchedules(schedules);
    _scheduleUpdateController.add(schedules);
  }

  /// Toggle schedule enabled/disabled
  Future<void> toggleSchedule(String scheduleId, bool enabled) async {
    final schedules = await getSchedules();
    final index = schedules.indexWhere((s) => s.scheduleId == scheduleId);
    if (index != -1) {
      schedules[index] = schedules[index].copyWith(isEnabled: enabled);
      await _saveSchedules(schedules);
      _scheduleUpdateController.add(schedules);
    }
  }

  /// Check if any schedules should run now
  Future<void> _checkSchedules() async {
    final schedules = await getSchedules();
    final now = DateTime.now();

    for (final schedule in schedules) {
      if (!schedule.isEnabled) continue;

      for (final time in schedule.scheduleTimes) {
        if (_shouldRunNow(time, now)) {
          await _executeSchedule(schedule, time);
        }
      }
    }
  }

  bool _shouldRunNow(ScheduleTime time, DateTime now) {
    // Check if current time matches scheduled time
    if (time.hour != now.hour || time.minute != now.minute) {
      return false;
    }

    // Check if today is a scheduled day (1=Monday, 7=Sunday)
    final dayOfWeek = now.weekday; // 1=Monday, 7=Sunday
    return time.daysOfWeek.contains(dayOfWeek);
  }

  Future<void> _executeSchedule(
    IrrigationSchedule schedule,
    ScheduleTime time,
  ) async {
    // Check conditions before running
    if (schedule.condition != null) {
      final shouldRun = await _checkConditions(
        schedule.condition!,
        schedule.zone,
      );
      if (!shouldRun) return;
    }

    // Get pump ID for this zone (simplified - in real app, map zone to pump)
    final pumpId = 'Pump-${schedule.zone.replaceAll('Zone ', '')}';

    // Turn on pump
    await _controlService.togglePump(pumpId: pumpId, turnOn: true);

    // Schedule automatic shutoff after duration
    Future.delayed(Duration(minutes: time.durationMinutes), () {
      _controlService.togglePump(pumpId: pumpId, turnOn: false);
    });

    // Update last run time
    final updatedSchedule = schedule.copyWith(lastRun: DateTime.now());
    await updateSchedule(updatedSchedule);
  }

  Future<bool> _checkConditions(
    ScheduleCondition condition,
    String zone,
  ) async {
    final cacheService = CacheService();
    final sensors = await cacheService.getCachedSensors() ?? [];
    final tanks = await cacheService.getCachedTanks() ?? [];

    return checkConditionMet(
      condition: condition,
      sensors: sensors,
      tanks: tanks,
      zone: zone,
    );
  }

  Future<void> _saveSchedules(List<IrrigationSchedule> schedules) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(schedules.map((s) => s.toJson()).toList());
    await prefs.setString(_schedulesKey, json);
  }

  /// Check conditions manually (for UI display)
  Future<bool> checkConditionMet({
    required ScheduleCondition condition,
    required List<SensorData> sensors,
    required List<TankLevel> tanks,
    required String zone,
  }) async {
    switch (condition.type) {
      case ConditionType.always:
        return true;

      case ConditionType.onlyIfDry:
        if (condition.moistureThreshold == null) return true;

        // Find sensors for this zone
        final zoneSensors = sensors.where((s) => s.location.contains(zone));
        if (zoneSensors.isEmpty) return false;

        // Check if any sensor is below threshold
        return zoneSensors.any(
          (s) => s.moistureLevel < condition.moistureThreshold!,
        );

      case ConditionType.skipIfTankLow:
        if (condition.tankMinLevel == null) return true;

        // Check if any tank is above minimum level
        return tanks.any((t) => t.levelPercentage >= condition.tankMinLevel!);
    }
  }

  void dispose() {
    _schedulerTimer?.cancel();
    _scheduleUpdateController.close();
  }
}
