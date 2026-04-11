import 'package:equatable/equatable.dart';
import '../utils/constants.dart';

/// Model representing soil moisture sensor data
class SensorData extends Equatable {
  final String sensorId;
  final double moistureLevel; // Percentage (0-100)
  final DateTime timestamp;
  final String status; // "Safe", "Critical", "Warning"
  final String location; // e.g., "Zone A", "Hillside Top"
  final double? temperature; // Celsius

  const SensorData({
    required this.sensorId,
    required this.moistureLevel,
    required this.timestamp,
    required this.status,
    required this.location,
    this.temperature,
  });

  /// Determine status based on moisture level
  factory SensorData.fromMoistureLevel({
    required String sensorId,
    required double moistureLevel,
    required String location,
    double? temperature,
  }) {
    String status;
    if (moistureLevel < AppConstants.criticalMoistureLevel) {
      status = 'Critical';
    } else if (moistureLevel < AppConstants.warningMoistureLevel) {
      status = 'Warning';
    } else {
      status = 'Safe';
    }

    return SensorData(
      sensorId: sensorId,
      moistureLevel: moistureLevel,
      timestamp: DateTime.now(),
      status: status,
      location: location,
      temperature: temperature,
    );
  }

  /// Create from Firebase/JSON data
  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      sensorId: json['sensorId'] as String,
      moistureLevel: (json['moistureLevel'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
      location: json['location'] as String,
      temperature: json['temperature'] != null ? (json['temperature'] as num).toDouble() : null,
    );
  }

  /// Convert to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'sensorId': sensorId,
      'moistureLevel': moistureLevel,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'location': location,
      if (temperature != null) 'temperature': temperature,
    };
  }

  @override
  List<Object?> get props => [
    sensorId,
    moistureLevel,
    timestamp,
    status,
    location,
    temperature,
  ];
}
