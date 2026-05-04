import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../l10n/app_localizations.dart';
import '../../models/water_usage.dart';
import '../../models/pump_status.dart';
import '../../models/environment_data.dart';
import '../../services/analytics_service.dart';
import '../../services/telemetry_service.dart';
import '../widgets/water_flow_gauge_widget.dart';
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
  List<EnvironmentData> _envHistory = [];
  bool _isLoading = true;
  String _selectedPeriod = 'Week';
  
  // New state for Day and Year
  List<Map<String, dynamic>> _hourlyData = [];
  List<Map<String, dynamic>> _yearlyData = [];
  List<PumpStatus> _pumps = [];
  StreamSubscription? _pumpSubscription;
  late final TelemetryService _telemetryService = TelemetryService(
    userId: widget.userId ?? FirebaseAuth.instance.currentUser?.uid ?? 'test_user',
  );
  
  double _totalUsed = 0.0;
  double _totalSaved = 0.0;
  double _efficiency = 0.0;
  Map<String, double> _statistics = {};
  double _trend = 0.0;

  @override
  void initState() {
    super.initState();
    _loadAnalytics();
    _startLiveMonitoring();
  }

  void _startLiveMonitoring() {
    _telemetryService.startPumpMonitoring();
    _pumpSubscription = _telemetryService.pumpStatusStream.listen((pumps) {
      if (mounted) {
        setState(() {
          _pumps = pumps;
        });
      }
    });
  }

  @override
  void dispose() {
    _pumpSubscription?.cancel();
    _telemetryService.dispose();
    super.dispose();
  }

  Future<void> _loadAnalytics() async {
    setState(() => _isLoading = true);

    try {
      List<WaterUsage> data;
      DateTime endDate = DateTime.now();
      DateTime startDate;

      if (_selectedPeriod == 'Day') {
        _hourlyData = await _analyticsService.getHourlyUsageDetail(endDate);
        startDate = DateTime(endDate.year, endDate.month, endDate.day);
        data = []; // Not used for Day view
      } else if (_selectedPeriod == 'Week') {
        data = await _analyticsService.getWeeklyUsage();
        startDate = endDate.subtract(const Duration(days: 7));
      } else if (_selectedPeriod == 'Month') {
        data = await _analyticsService.getMonthlyUsage();
        startDate = endDate.subtract(const Duration(days: 30));
      } else {
        // Year
        _yearlyData = await _analyticsService.getYearlySummarizedUsage(endDate.year);
        startDate = DateTime(endDate.year, 1, 1);
        data = []; // Not used for Year view
      }

      final envData = await _analyticsService.getEnvironmentHistory(
        startDate: startDate,
        endDate: endDate,
      );

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
          _envHistory = envData;
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
          _envHistory = [];
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
        title: Text(AppLocalizations.of(context)!.waterUsageAnalytics),
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

                      if (_selectedPeriod == 'Day' && _pumps.isNotEmpty) ...[
                        _buildSectionHeader(AppLocalizations.of(context)!.realTimeFlowMonitoring),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 300,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _pumps.length,
                            separatorBuilder: (c, i) => const SizedBox(width: 16),
                            itemBuilder: (c, i) => SizedBox(
                              width: 280,
                              child: WaterFlowGaugeWidget(
                                flowRate: _pumps[i].flowRate,
                                pumpId: _pumps[i].pumpId,
                                isActive: _pumps[i].isActive,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      _buildStatisticsCards(),
                      const SizedBox(height: 24),
                      if (_envHistory.isNotEmpty) ...[
                        _buildSectionHeader(AppLocalizations.of(context)!.climateAnalysis),
                        const SizedBox(height: 8),
                        _buildClimateChart(),
                        const SizedBox(height: 24),
                      ],
                      _buildSectionHeader(AppLocalizations.of(context)!.usageAnalysis),
                      const SizedBox(height: 8),
                      _buildMainUsageChart(),
                      const SizedBox(height: 24),
                      if (_selectedPeriod == 'Week' || _selectedPeriod == 'Month') ...[
                        _buildSectionHeader(AppLocalizations.of(context)!.waterConservation),
                        const SizedBox(height: 8),
                        _buildSavingsChart(),
                        const SizedBox(height: 24),
                        _buildSectionHeader(AppLocalizations.of(context)!.irrigationActivity),
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
    final l10n = AppLocalizations.of(context)!;
    return SegmentedButton<String>(
      segments: [
        ButtonSegment(value: 'Day', label: Text(l10n.today)),
        ButtonSegment(value: 'Week', label: Text(l10n.week)),
        ButtonSegment(value: 'Month', label: Text(l10n.month)),
        ButtonSegment(value: 'Year', label: Text(l10n.year)),
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
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                l10n.waterUsed,
                '${_totalUsed.toStringAsFixed(0)} L',
                Icons.water_drop,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                l10n.waterSaved,
                '${_totalSaved.toStringAsFixed(0)} L',
                Icons.eco,
                Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                l10n.efficiency,
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
    final l10n = AppLocalizations.of(context)!;
    final trendText = _trend > 0 
        ? l10n.increasing(_trend.toStringAsFixed(1))
        : _trend < 0
            ? l10n.decreasing(_trend.toStringAsFixed(1))
            : l10n.stable;
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
                    AppLocalizations.of(context)!.usageTrend,
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
                Builder(builder: (context) {
                  final l10n = AppLocalizations.of(context)!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${l10n.avg}: ${_statistics['average']?.toStringAsFixed(0) ?? '0'} L',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${l10n.range}: ${_statistics['min']?.toStringAsFixed(0) ?? '0'}-${_statistics['max']?.toStringAsFixed(0) ?? '0'} L',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  );
                }),
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
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 250,
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: l10n.liters),
              ),
            legend: const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              ColumnSeries<WaterUsage, String>(
                name: l10n.saved,
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

  Widget _buildMainUsageChart() {
    final l10n = AppLocalizations.of(context)!;
    String yAxisTitle = _selectedPeriod == 'Day' ? '${l10n.waterFlowRate} (${l10n.litersPerMinute})' : l10n.liters;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 300,
          child: SfCartesianChart(
            primaryXAxis: _selectedPeriod == 'Day' 
                ? NumericAxis(title: AxisTitle(text: l10n.hourOfDay), interval: 4)
                : const CategoryAxis(),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: yAxisTitle),
              labelFormat: '{value}',
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            legend: const Legend(isVisible: false),
            series: <CartesianSeries>[
              if (_selectedPeriod == 'Day')
                AreaSeries<Map<String, dynamic>, int>(
                  name: l10n.flowLevel,
                  dataSource: _hourlyData,
                  xValueMapper: (data, _) => data['hour'] as int,
                  yValueMapper: (data, _) => data['litersUsed'] as double,
                  color: Colors.blue.withValues(alpha: 0.3),
                  borderColor: Colors.blue,
                  borderWidth: 2,
                )
              else if (_selectedPeriod == 'Year')
                ColumnSeries<Map<String, dynamic>, String>(
                  name: l10n.monthlyTotal,
                  dataSource: _yearlyData,
                  xValueMapper: (data, _) => DateFormat('MMM').format(DateTime(2026, data['month'] as int)),
                  yValueMapper: (data, _) => data['litersUsed'] as double,
                  color: Colors.blue,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                )
              else
                LineSeries<WaterUsage, String>(
                  name: l10n.dailyUsage,
                  dataSource: _weeklyData,
                  xValueMapper: (WaterUsage usage, _) => 
                      _selectedPeriod == 'Week' 
                          ? DateFormat('E').format(usage.date) 
                          : DateFormat('MMM d').format(usage.date),
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


  Widget _buildClimateChart() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 250,
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            primaryYAxis: const NumericAxis(
              title: AxisTitle(text: '°C / %'),
            ),
            legend: const Legend(isVisible: true, position: LegendPosition.bottom),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              SplineSeries<EnvironmentData, String>(
                name: l10n.temperature,
                dataSource: _envHistory,
                xValueMapper: (data, _) => _selectedPeriod == 'Day'
                    ? DateFormat('HH:mm').format(data.timestamp)
                    : DateFormat('MMM d').format(data.timestamp),
                yValueMapper: (data, _) => data.temperature,
                color: Colors.orangeAccent,
                width: 2,
                markerSettings: const MarkerSettings(isVisible: false),
              ),
              SplineSeries<EnvironmentData, String>(
                name: l10n.humidity,
                dataSource: _envHistory,
                xValueMapper: (data, _) => _selectedPeriod == 'Day'
                    ? DateFormat('HH:mm').format(data.timestamp)
                    : DateFormat('MMM d').format(data.timestamp),
                yValueMapper: (data, _) => data.humidity,
                color: Colors.blueAccent,
                width: 2,
                markerSettings: const MarkerSettings(isVisible: false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivationChart() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 250,
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: l10n.activations),
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
