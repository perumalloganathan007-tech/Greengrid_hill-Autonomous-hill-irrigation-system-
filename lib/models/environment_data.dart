import 'package:equatable/equatable.dart';

/// Model representing DHT22 ambient temperature and humidity data
class EnvironmentData extends Equatable {
  final double temperature; // Celsius
  final double humidity; // Percentage (0-100)
  final DateTime timestamp;

  const EnvironmentData({
    required this.temperature,
    required this.humidity,
    required this.timestamp,
  });

  /// Create from Firebase/JSON data
  factory EnvironmentData.fromJson(Map<String, dynamic> json) {
    return EnvironmentData(
      temperature: (json['temperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      timestamp: json['timestamp'] != null 
          ? DateTime.tryParse(json['timestamp'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  /// Convert to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'humidity': humidity,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    temperature,
    humidity,
    timestamp,
  ];
}
