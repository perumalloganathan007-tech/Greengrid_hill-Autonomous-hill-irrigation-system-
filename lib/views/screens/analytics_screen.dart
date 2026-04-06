import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../models/water_usage.dart';
import '../../services/analytics_service.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Analytics screen showing water usage charts and statistics
class AnalyticsScreen extends StatefulWidget {
  final String? userId;

  const AnalyticsScreen({super.key, this.userId});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  late final AnalyticsService _analyticsService = AnalyticsService(
    userId: widget.userId ?? FirebaseAuth.instance.currentUser?.uid ?? 'test_user',
  );
  List<WaterUsage> _weeklyData = [];
  bool _isLoading = true;
  String _selectedPeriod = 'Week';
  
  double _totalUsed = 0.0;
  double _totalSaved = 0.0;
  double _efficiency = 0.0;
  Map<String, double> _statistics = {};
  double _trend = 0.0;

  @override
  void initState() {
    super.initState();
    _loadAnalytics();
  }

  Future<void> _loadAnalytics() async {
    setState(() => _isLoading = true);

    try {
      List<WaterUsage> data;
      DateTime endDate = DateTime.now();
      DateTime startDate;

      if (_selectedPeriod == 'Week') {
        data = await _analyticsService.getWeeklyUsage();
        startDate = endDate.subtract(const Duration(days: 7));
      } else {
        data = await _analyticsService.getMonthlyUsage();
        startDate = endDate.subtract(const Duration(days: 30));
      }

      // Calculate statistics
      final totalUsed = await _analyticsService.getTotalLitersUsed(
        startDate: startDate,
        endDate: endDate,
      );
      final totalSaved = await _analyticsService.getTotalLitersSaved(
        startDate: startDate,
        endDate: endDate,
      );
      final efficiency = await _analyticsService.getEfficiencyPercentage(
        startDate: startDate,
        endDate: endDate,
      );
      final statistics = await _analyticsService.getStatistics(
        startDate: startDate,
        endDate: endDate,
      );
      final trend = await _analyticsService.getTrend(
        startDate: startDate,
        endDate: endDate,
      );

      if (mounted) {
        setState(() {
          _weeklyData = data;
          _totalUsed = totalUsed;
          _totalSaved = totalSaved;
          _efficiency = efficiency;
          _statistics = statistics.isEmpty 
              ? {'average': 0.0, 'min': 0.0, 'max': 0.0, 'total': 0.0}
              : statistics;
          _trend = trend;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _weeklyData = [];
          _totalUsed = 0.0;
          _totalSaved = 0.0;
          _efficiency = 0.0;
          _statistics = {'average': 0.0, 'min': 0.0, 'max': 0.0, 'total': 0.0};
          _trend = 0.0;
          _isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Usage Analytics'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadAnalytics,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPeriodSelector(),
                    const SizedBox(height: 20),
                    if (_weeklyData.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(
                          child: Text('Data is not initialized or no usage data found.'),
                        ),
                      )
                    else ...[
                      _buildStatisticsCards(),
                      const SizedBox(height: 24),
                      _buildSectionHeader('Water Conservation'),
                      const SizedBox(height: 8),
                      _buildSavingsChart(),
                      const SizedBox(height: 24),
                      _buildSectionHeader('Daily Usage Trend'),
                      const SizedBox(height: 8),
                      _buildUsageChart(),
                      const SizedBox(height: 24),
                      _buildSectionHeader('Irrigation Activity'),
                      const SizedBox(height: 8),
                      _buildActivationChart(),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildPeriodSelector() {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'Week', label: Text('Last 7 Days')),
        ButtonSegment(value: 'Month', label: Text('Last 30 Days')),
      ],
      selected: {_selectedPeriod},
      onSelectionChanged: (Set<String> selected) {
        setState(() {
          _selectedPeriod = selected.first;
        });
        _loadAnalytics();
      },
    );
  }

  Widget _buildStatisticsCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Water Used',
                '${_totalUsed.toStringAsFixed(0)} L',
                Icons.water_drop,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Water Saved',
                '${_totalSaved.toStringAsFixed(0)} L',
                Icons.eco,
                Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Efficiency',
                '${_efficiency.toStringAsFixed(1)}%',
                Icons.trending_up,
                Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTrendCard(),
      ],
    );
  }

  Widget _buildTrendCard() {
    final trendText = _trend > 0 
        ? 'Increasing +${_trend.toStringAsFixed(1)} L/day'
        : _trend < 0
            ? 'Decreasing ${_trend.toStringAsFixed(1)} L/day'
            : 'Stable';
    final trendIcon = _trend > 0 
        ? Icons.trending_up 
        : _trend < 0 
            ? Icons.trending_down 
            : Icons.trending_flat;
    final trendColor = _trend > 0 
        ? Colors.orange 
        : _trend < 0 
            ? Colors.green 
            : Colors.grey;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(trendIcon, size: 32, color: trendColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Usage Trend',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    trendText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: trendColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Avg: ${_statistics['average']?.toStringAsFixed(0) ?? '0'} L',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  'Range: ${_statistics['min']?.toStringAsFixed(0) ?? '0'}-${_statistics['max']?.toStringAsFixed(0) ?? '0'} L',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSavingsChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 250,
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            primaryYAxis: const NumericAxis(
              title: AxisTitle(text: 'Liters'),
            ),
            legend: const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              ColumnSeries<WaterUsage, String>(
                name: 'Saved',
                dataSource: _weeklyData,
                xValueMapper: (WaterUsage usage, _) => DateFormat('E').format(usage.date),
                yValueMapper: (WaterUsage usage, _) => usage.litersSaved,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsageChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 250,
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            primaryYAxis: const NumericAxis(
              title: AxisTitle(text: 'Liters'),
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              LineSeries<WaterUsage, String>(
                dataSource: _weeklyData,
                xValueMapper: (WaterUsage usage, _) => DateFormat('MMM d').format(usage.date),
                yValueMapper: (WaterUsage usage, _) => usage.litersUsed,
                color: Colors.blue,
                markerSettings: const MarkerSettings(isVisible: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivationChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 250,
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            primaryYAxis: const NumericAxis(
              title: AxisTitle(text: 'Activations'),
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              BarSeries<WaterUsage, String>(
                dataSource: _weeklyData,
                xValueMapper: (WaterUsage usage, _) => DateFormat('E').format(usage.date),
                yValueMapper: (WaterUsage usage, _) => usage.activationCount,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
