import 'package:equatable/equatable.dart';

/// Model representing water tank level data
class TankLevel extends Equatable {
  final String tankId;
  final double levelPercentage; // 0-100%
  final double volumeLiters; // Current volume in liters
  final double capacityLiters; // Total tank capacity
  final DateTime timestamp;
  final String status; // "Full", "Normal", "Low", "Critical"

  const TankLevel({
    required this.tankId,
    required this.levelPercentage,
    required this.volumeLiters,
    required this.capacityLiters,
    required this.timestamp,
    required this.status,
  });

  /// Determine status based on level percentage
  factory TankLevel.fromLevel({
    required String tankId,
    required double levelPercentage,
    required double capacityLiters,
  }) {
    String status;
    if (levelPercentage >= 80) {
      status = 'Full';
    } else if (levelPercentage >= 30) {
      status = 'Normal';
    } else if (levelPercentage >= 15) {
      status = 'Low';
    } else {
      status = 'Critical';
    }

    return TankLevel(
      tankId: tankId,
      levelPercentage: levelPercentage,
      volumeLiters: (levelPercentage / 100) * capacityLiters,
      capacityLiters: capacityLiters,
      timestamp: DateTime.now(),
      status: status,
    );
  }

  /// Create from Firebase/JSON data
  factory TankLevel.fromJson(Map<String, dynamic> json) {
    return TankLevel(
      tankId: json['tankId'] as String,
      levelPercentage: (json['levelPercentage'] as num).toDouble(),
      volumeLiters: (json['volumeLiters'] as num).toDouble(),
      capacityLiters: (json['capacityLiters'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
    );
  }

  /// Convert to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'tankId': tankId,
      'levelPercentage': levelPercentage,
      'volumeLiters': volumeLiters,
      'capacityLiters': capacityLiters,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
    };
  }

  @override
  List<Object?> get props => [tankId, levelPercentage, volumeLiters, capacityLiters, timestamp, status];
}
