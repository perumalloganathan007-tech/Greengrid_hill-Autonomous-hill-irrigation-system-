import 'package:equatable/equatable.dart';

/// Model for irrigation schedule configuration
class IrrigationSchedule extends Equatable {
  final String scheduleId;
  final String zone;
  final List<ScheduleTime> scheduleTimes;
  final bool isEnabled;
  final ScheduleCondition? condition;
  final DateTime createdAt;
  final DateTime? lastRun;

  const IrrigationSchedule({
    required this.scheduleId,
    required this.zone,
    required this.scheduleTimes,
    this.isEnabled = true,
    this.condition,
    required this.createdAt,
    this.lastRun,
  });

  @override
  List<Object?> get props => [
    scheduleId,
    zone,
    scheduleTimes,
    isEnabled,
    condition,
    createdAt,
    lastRun,
  ];

  IrrigationSchedule copyWith({
    String? scheduleId,
    String? zone,
    List<ScheduleTime>? scheduleTimes,
    bool? isEnabled,
    ScheduleCondition? condition,
    DateTime? createdAt,
    DateTime? lastRun,
  }) {
    return IrrigationSchedule(
      scheduleId: scheduleId ?? this.scheduleId,
      zone: zone ?? this.zone,
      scheduleTimes: scheduleTimes ?? this.scheduleTimes,
      isEnabled: isEnabled ?? this.isEnabled,
      condition: condition ?? this.condition,
      createdAt: createdAt ?? this.createdAt,
      lastRun: lastRun ?? this.lastRun,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scheduleId': scheduleId,
      'zone': zone,
      'scheduleTimes': scheduleTimes.map((t) => t.toJson()).toList(),
      'isEnabled': isEnabled,
      'condition': condition?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'lastRun': lastRun?.toIso8601String(),
    };
  }

  factory IrrigationSchedule.fromJson(Map<String, dynamic> json) {
    return IrrigationSchedule(
      scheduleId: json['scheduleId'],
      zone: json['zone'],
      scheduleTimes: (json['scheduleTimes'] as List)
          .map((t) => ScheduleTime.fromJson(t))
          .toList(),
      isEnabled: json['isEnabled'] ?? true,
      condition: json['condition'] != null
          ? ScheduleCondition.fromJson(json['condition'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      lastRun: json['lastRun'] != null ? DateTime.parse(json['lastRun']) : null,
    );
  }
}

/// Individual schedule time entry
class ScheduleTime extends Equatable {
  final int hour; // 0-23
  final int minute; // 0-59
  final int durationMinutes;
  final List<int> daysOfWeek; // 1=Monday, 7=Sunday

  const ScheduleTime({
    required this.hour,
    required this.minute,
    required this.durationMinutes,
    required this.daysOfWeek,
  });

  @override
  List<Object?> get props => [hour, minute, durationMinutes, daysOfWeek];

  String get timeString {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
      'durationMinutes': durationMinutes,
      'daysOfWeek': daysOfWeek,
    };
  }

  factory ScheduleTime.fromJson(Map<String, dynamic> json) {
    return ScheduleTime(
      hour: json['hour'],
      minute: json['minute'],
      durationMinutes: json['durationMinutes'],
      daysOfWeek: List<int>.from(json['daysOfWeek']),
    );
  }
}

/// Optional condition that must be met for schedule to run
class ScheduleCondition extends Equatable {
  final ConditionType type;
  final double? moistureThreshold;
  final double? tankMinLevel;

  const ScheduleCondition({
    required this.type,
    this.moistureThreshold,
    this.tankMinLevel,
  });

  @override
  List<Object?> get props => [type, moistureThreshold, tankMinLevel];

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'moistureThreshold': moistureThreshold,
      'tankMinLevel': tankMinLevel,
    };
  }

  factory ScheduleCondition.fromJson(Map<String, dynamic> json) {
    return ScheduleCondition(
      type: ConditionType.values.firstWhere(
        (e) => e.toString() == json['type'],
      ),
      moistureThreshold: json['moistureThreshold'],
      tankMinLevel: json['tankMinLevel'],
    );
  }
}

enum ConditionType {
  always, // Run every scheduled time
  onlyIfDry, // Run only if moisture below threshold
  skipIfTankLow, // Skip if tank level too low
}
