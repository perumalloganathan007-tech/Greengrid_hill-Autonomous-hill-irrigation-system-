import 'package:equatable/equatable.dart';

/// Model representing pump/solenoid valve status
class PumpStatus extends Equatable {
  final String pumpId;
  final bool isActive; // ON/OFF status
  final double flowRate; // Liters per minute
  final double pressure; // PSI or bar
  final DateTime lastToggled;
  final String controlMode; // "Auto", "Manual Override"
  final String zone; // Irrigation zone

  const PumpStatus({
    required this.pumpId,
    required this.isActive,
    required this.flowRate,
    required this.pressure,
    required this.lastToggled,
    required this.controlMode,
    required this.zone,
  });

  /// Create from Firebase/JSON data
  factory PumpStatus.fromJson(Map<String, dynamic> json) {
    return PumpStatus(
      pumpId: json['pumpId'] as String,
      isActive: json['isActive'] as bool,
      flowRate: (json['flowRate'] as num).toDouble(),
      pressure: (json['pressure'] as num).toDouble(),
      lastToggled: DateTime.parse(json['lastToggled'] as String),
      controlMode: json['controlMode'] as String,
      zone: json['zone'] as String,
    );
  }

  /// Convert to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'pumpId': pumpId,
      'isActive': isActive,
      'flowRate': flowRate,
      'pressure': pressure,
      'lastToggled': lastToggled.toIso8601String(),
      'controlMode': controlMode,
      'zone': zone,
    };
  }

  /// Create a copy with modified fields
  PumpStatus copyWith({
    String? pumpId,
    bool? isActive,
    double? flowRate,
    double? pressure,
    DateTime? lastToggled,
    String? controlMode,
    String? zone,
  }) {
    return PumpStatus(
      pumpId: pumpId ?? this.pumpId,
      isActive: isActive ?? this.isActive,
      flowRate: flowRate ?? this.flowRate,
      pressure: pressure ?? this.pressure,
      lastToggled: lastToggled ?? this.lastToggled,
      controlMode: controlMode ?? this.controlMode,
      zone: zone ?? this.zone,
    );
  }

  @override
  List<Object?> get props => [pumpId, isActive, flowRate, pressure, lastToggled, controlMode, zone];
}
