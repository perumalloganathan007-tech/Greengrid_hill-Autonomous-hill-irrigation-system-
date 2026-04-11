import 'package:equatable/equatable.dart';

/// Model representing a single terrace level
class TerraceData extends Equatable {
  final int terraceLevel; // 1 = Top, 2 = Middle, N = Bottom
  final String zoneName;
  final double? slopeFactor;

  const TerraceData({
    required this.terraceLevel,
    required this.zoneName,
    this.slopeFactor,
  });

  factory TerraceData.fromJson(Map<String, dynamic> json) {
    return TerraceData(
      terraceLevel: json['terraceLevel'] as int,
      zoneName: json['zoneName'] as String,
      slopeFactor: json['slopeFactor'] != null ? (json['slopeFactor'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'terraceLevel': terraceLevel,
      'zoneName': zoneName,
      if (slopeFactor != null) 'slopeFactor': slopeFactor,
    };
  }

  @override
  List<Object?> get props => [terraceLevel, zoneName, slopeFactor];
}
