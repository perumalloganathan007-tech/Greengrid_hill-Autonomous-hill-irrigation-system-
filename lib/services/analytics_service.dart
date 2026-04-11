import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import '../models/water_usage.dart';

/// Service for retrieving and analyzing historical water usage data
class AnalyticsService {
  FirebaseDatabase? _database;
  DatabaseReference? _analyticsRef;
  bool _useFirebase = false;
  final String userId;
  AnalyticsService({this.userId = ''}) {
    try {
      _database = FirebaseDatabase.instance;
      _analyticsRef = _database!.ref('analytics/water_usage');
      _useFirebase = true;
    } catch (e) {
      // Firebase not initialized
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
            usageList.add(
              WaterUsage.fromJson(Map<String, dynamic>.from(value)),
            );
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

  /// Get hourly usage for the current day
  /// Assumes a path analytics/hourly_usage exists or logic to fetch granular data
  Future<List<Map<String, dynamic>>> getHourlyUsageDetail(DateTime date) async {
    if (!_useFirebase || _database == null) {
      return [];
    }

    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    final ref = _database!.ref('analytics/hourly_usage/$dateStr');

    try {
      final snapshot = await ref.get();
      if (snapshot.exists && snapshot.value != null) {
        final data = snapshot.value as Map;
        final List<Map<String, dynamic>> hourlyData = [];
        data.forEach((key, value) {
          hourlyData.add({
            'hour': int.tryParse(key.toString()) ?? 0,
            'litersUsed': (value['litersUsed'] as num).toDouble(),
          });
        });
        hourlyData.sort((a, b) => a['hour'].compareTo(b['hour']));
        return hourlyData;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Get monthly summarized usage for a year
  Future<List<Map<String, dynamic>>> getYearlySummarizedUsage(int year) async {
    final startDate = DateTime(year, 1, 1);
    final endDate = DateTime(year, 12, 31, 23, 59, 59);
    
    final dailyData = await getUsageData(startDate: startDate, endDate: endDate);
    if (dailyData.isEmpty) return [];

    // Group by month
    final Map<int, double> monthlyTotals = {};
    for (var usage in dailyData) {
      final month = usage.date.month;
      monthlyTotals[month] = (monthlyTotals[month] ?? 0.0) + usage.litersUsed;
    }

    final List<Map<String, dynamic>> yearlyData = [];
    for (int i = 1; i <= 12; i++) {
      yearlyData.add({
        'month': i,
        'litersUsed': monthlyTotals[i] ?? 0.0,
      });
    }
    return yearlyData;
  }

  /// Calculate total liters saved in a date range
  Future<double> getTotalLitersSaved({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(
      startDate: startDate,
      endDate: endDate,
    );
    return usageData.fold<double>(0.0, (sum, item) => sum + item.litersSaved);
  }

  /// Calculate total liters used in a date range
  Future<double> getTotalLitersUsed({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(
      startDate: startDate,
      endDate: endDate,
    );
    return usageData.fold<double>(0.0, (sum, item) => sum + item.litersUsed);
  }

  /// Get average daily moisture level
  Future<double> getAverageMoisture({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(
      startDate: startDate,
      endDate: endDate,
    );
    if (usageData.isEmpty) return 0.0;

    final total = usageData.fold<double>(
      0.0,
      (sum, item) => sum + item.averageMoisture,
    );
    return total / usageData.length;
  }

  /// Get irrigation efficiency percentage
  Future<double> getEfficiencyPercentage({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(
      startDate: startDate,
      endDate: endDate,
    );
    if (usageData.isEmpty) return 0.0;

    final totalUsed = usageData.fold<double>(
      0.0,
      (sum, item) => sum + item.litersUsed,
    );
    final totalSaved = usageData.fold<double>(
      0.0,
      (sum, item) => sum + item.litersSaved,
    );

    if (totalUsed + totalSaved == 0) return 0.0;

    return (totalSaved / (totalUsed + totalSaved)) * 100;
  }

  /// Calculate trend (positive = increasing, negative = decreasing)
  Future<double> getTrend({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(
      startDate: startDate,
      endDate: endDate,
    );
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
    final usageData = await getUsageData(
      startDate: startDate,
      endDate: endDate,
    );
    if (usageData.isEmpty) return null;

    return usageData.reduce((a, b) => a.litersUsed > b.litersUsed ? a : b);
  }

  /// Get lowest usage day
  Future<WaterUsage?> getLowestUsageDay({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(
      startDate: startDate,
      endDate: endDate,
    );
    if (usageData.isEmpty) return null;

    return usageData.reduce((a, b) => a.litersUsed < b.litersUsed ? a : b);
  }

  /// Get average, min, max statistics
  Future<Map<String, double>> getStatistics({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final usageData = await getUsageData(
      startDate: startDate,
      endDate: endDate,
    );
    if (usageData.isEmpty) {
      return {'average': 0.0, 'min': 0.0, 'max': 0.0};
    }

    final total = usageData.fold<double>(
      0.0,
      (sum, item) => sum + item.litersUsed,
    );
    final average = total / usageData.length;
    final min = usageData
        .map((e) => e.litersUsed)
        .reduce((a, b) => a < b ? a : b);
    final max = usageData
        .map((e) => e.litersUsed)
        .reduce((a, b) => a > b ? a : b);

    return {'average': average, 'min': min, 'max': max, 'total': total};
  }
}
