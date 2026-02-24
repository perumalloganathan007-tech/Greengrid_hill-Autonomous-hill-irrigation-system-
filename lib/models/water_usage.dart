import 'package:equatable/equatable.dart';

/// Model for water usage analytics data
class WaterUsage extends Equatable {
  final DateTime date;
  final double litersUsed;
  final double litersSaved; // Compared to traditional irrigation
  final int activationCount; // Number of times irrigation activated
  final double averageMoisture; // Average soil moisture for the day

  const WaterUsage({
    required this.date,
    required this.litersUsed,
    required this.litersSaved,
    required this.activationCount,
    required this.averageMoisture,
  });

  /// Create from Firebase/JSON data
  factory WaterUsage.fromJson(Map<String, dynamic> json) {
    return WaterUsage(
      date: DateTime.parse(json['date'] as String),
      litersUsed: (json['litersUsed'] as num).toDouble(),
      litersSaved: (json['litersSaved'] as num).toDouble(),
      activationCount: json['activationCount'] as int,
      averageMoisture: (json['averageMoisture'] as num).toDouble(),
    );
  }

  /// Convert to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'litersUsed': litersUsed,
      'litersSaved': litersSaved,
      'activationCount': activationCount,
      'averageMoisture': averageMoisture,
    };
  }

  @override
  List<Object?> get props => [date, litersUsed, litersSaved, activationCount, averageMoisture];
}
