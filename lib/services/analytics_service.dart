import 'package:firebase_database/firebase_database.dart';
import '../models/water_usage.dart';

/// Service for retrieving and analyzing historical water usage data
/// Falls back to demo data if Firebase is not configured
class AnalyticsService {
  FirebaseDatabase? _database;
  DatabaseReference? _analyticsRef;
  bool _useFirebase = false;

  AnalyticsService() {
    try {
      _database = FirebaseDatabase.instance;
      _analyticsRef = _database!.ref('analytics/water_usage');
      _useFirebase = true;
    } catch (e) {
      // Firebase not initialized, will use demo data
      _useFirebase = false;
    }
  }

  /// Get water usage data for a specific date range
  Future<List<WaterUsage>> getUsageData({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    if (!_useFirebase || _analyticsRef == null) {
      return [];
    }
    
    try {
      final snapshot = await _analyticsRef!
          .orderByChild('date')
          .startAt(startDate.toIso8601String())
          .endAt(endDate.toIso8601String())
          .get();

      if (snapshot.exists && snapshot.value != null) {
        final data = snapshot.value as Map;
        final List<WaterUsage> usageList = [];
        
        data.forEach((key, value) {
          if (value is Map) {
            usageList.add(WaterUsage.fromJson(Map<String, dynamic>.from(value)));
          }
        });

        // Sort by date
        usageList.sort((a, b) => a.date.compareTo(b.date));
        return usageList;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Get last 7 days of water usage
  Future<List<WaterUsage>> getWeeklyUsage() async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 7));
    return getUsageData(startDate: startDate, endDate: endDate);
  }

  /// Get last 30 days of water usage
  Future<List<WaterUsage>> getMonthlyUsage() async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 30));
    return getUsageData(startDate: startDate, endDate: endDate);
  }

  /// Calculate total liters saved in a date range
  Future<double> getTotalLitersSaved({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(startDate: startDate, endDate: endDate);
    return usageData.fold<double>(0.0, (sum, item) => sum + item.litersSaved);
  }

  /// Calculate total liters used in a date range
  Future<double> getTotalLitersUsed({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(startDate: startDate, endDate: endDate);
    return usageData.fold<double>(0.0, (sum, item) => sum + item.litersUsed);
  }

  /// Get average daily moisture level
  Future<double> getAverageMoisture({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(startDate: startDate, endDate: endDate);
    if (usageData.isEmpty) return 0.0;
    
    final total = usageData.fold<double>(0.0, (sum, item) => sum + item.averageMoisture);
    return total / usageData.length;
  }

  /// Get irrigation efficiency percentage
  Future<double> getEfficiencyPercentage({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(startDate: startDate, endDate: endDate);
    if (usageData.isEmpty) return 0.0;

    final totalUsed = usageData.fold<double>(0.0, (sum, item) => sum + item.litersUsed);
    final totalSaved = usageData.fold<double>(0.0, (sum, item) => sum + item.litersSaved);
    
    if (totalUsed + totalSaved == 0) return 0.0;
    
    return (totalSaved / (totalUsed + totalSaved)) * 100;
  }

  /// Calculate trend (positive = increasing, negative = decreasing)
  Future<double> getTrend({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(startDate: startDate, endDate: endDate);
    if (usageData.length < 2) return 0.0;

    // Calculate linear regression slope
    final n = usageData.length;
    double sumX = 0, sumY = 0, sumXY = 0, sumX2 = 0;

    for (int i = 0; i < n; i++) {
      final x = i.toDouble();
      final y = usageData[i].litersUsed;
      sumX += x;
      sumY += y;
      sumXY += x * y;
      sumX2 += x * x;
    }

    final slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
    return slope;
  }

  /// Get peak usage day
  Future<WaterUsage?> getPeakUsageDay({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(startDate: startDate, endDate: endDate);
    if (usageData.isEmpty) return null;

    return usageData.reduce((a, b) => a.litersUsed > b.litersUsed ? a : b);
  }

  /// Get lowest usage day
  Future<WaterUsage?> getLowestUsageDay({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(startDate: startDate, endDate: endDate);
    if (usageData.isEmpty) return null;

    return usageData.reduce((a, b) => a.litersUsed < b.litersUsed ? a : b);
  }

  /// Get average, min, max statistics
  Future<Map<String, double>> getStatistics({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(startDate: startDate, endDate: endDate);
    if (usageData.isEmpty) {
      return {'average': 0.0, 'min': 0.0, 'max': 0.0};
    }

    final total = usageData.fold<double>(0.0, (sum, item) => sum + item.litersUsed);
    final average = total / usageData.length;
    final min = usageData.map((e) => e.litersUsed).reduce((a, b) => a < b ? a : b);
    final max = usageData.map((e) => e.litersUsed).reduce((a, b) => a > b ? a : b);

    return {
      'average': average,
      'min': min,
      'max': max,
      'total': total,
    };
  }
}
