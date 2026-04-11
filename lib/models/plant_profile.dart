import 'package:equatable/equatable.dart';

/// Model representing a plant profile for irrigation
class PlantProfile extends Equatable {
  final String plantName;
  final double minMoisture; // Threshold before irrigation is triggered
  final double maxMoisture; // Stop irrigation when reached
  final double optimalTemperature;
  final Duration baseWaterDuration; // Base duration before temperature modifiers

  const PlantProfile({
    required this.plantName,
    required this.minMoisture,
    required this.maxMoisture,
    required this.optimalTemperature,
    required this.baseWaterDuration,
  });

  /// Factory for JSON
  factory PlantProfile.fromJson(Map<String, dynamic> json) {
    return PlantProfile(
      plantName: json['plantName'] as String,
      minMoisture: (json['minMoisture'] as num).toDouble(),
      maxMoisture: (json['maxMoisture'] as num).toDouble(),
      optimalTemperature: (json['optimalTemperature'] as num).toDouble(),
      baseWaterDuration: Duration(seconds: json['baseWaterDurationSeconds'] as int),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'plantName': plantName,
      'minMoisture': minMoisture,
      'maxMoisture': maxMoisture,
      'optimalTemperature': optimalTemperature,
      'baseWaterDurationSeconds': baseWaterDuration.inSeconds,
    };
  }

  @override
  List<Object?> get props => [
        plantName,
        minMoisture,
        maxMoisture,
        optimalTemperature,
        baseWaterDuration,
      ];
}
