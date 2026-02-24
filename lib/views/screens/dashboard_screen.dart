import 'package:flutter/material.dart';
import '../../models/sensor_data.dart';
import '../../models/tank_level.dart';
import '../../models/pump_status.dart';
import '../../services/telemetry_service.dart';
import '../../services/control_service.dart';
import '../../services/notification_service.dart';
import '../widgets/moisture_gauge_widget.dart';
import '../widgets/tank_level_widget.dart';
import '../widgets/pump_control_widget.dart';

/// Main dashboard screen displaying real-time telemetry and controls
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TelemetryService _telemetryService = TelemetryService();
  final ControlService _controlService = ControlService(
    esp32BaseUrl: 'http://192.168.1.100', // TODO: Make this configurable
  );
  final NotificationService _notificationService = NotificationService();

  List<SensorData> _sensors = [];
  List<TankLevel> _tanks = [];
  final List<PumpStatus> _pumps = [];
  bool _isLoading = true;
  bool _isConnected = false;
  DateTime? _lastUpdate;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _notificationService.initialize();
  }

  Future<void> _initializeData() async {
    setState(() {
      _isLoading = true;
      _isConnected = false;
    });

    // Start real-time monitoring
    _telemetryService.startSensorMonitoring();
    _telemetryService.startTankMonitoring();

    // Listen to sensor stream
    _telemetryService.sensorDataStream.listen((sensors) {
      if (mounted) {
        setState(() {
          _sensors = sensors;
          _isLoading = false;
          _isConnected = true;
          _lastUpdate = DateTime.now();
        });
        // Check for alerts
        _notificationService.checkSensorAlerts(sensors);
      }
    });

    // Listen to tank stream
    _telemetryService.tankLevelStream.listen((tanks) {
      if (mounted) {
        setState(() {
          _tanks = tanks;
        });
        // Check for tank alerts
        _notificationService.checkTankAlerts(tanks);
      }
    });

    // Load initial pump data (simulated for demo)
    _loadPumpData();
    
    // Set timeout to show demo data if Firebase doesn't respond
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && _isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _loadPumpData() {
    // TODO: Replace with actual ESP32 data fetch
    setState(() {
      _pumps.add(
        PumpStatus(
          pumpId: 'Pump-1',
          isActive: false,
          flowRate: 0.0,
          pressure: 45.5,
          lastToggled: DateTime.now(),
          controlMode: 'Auto',
          zone: 'Zone A',
        ),
      );
      _pumps.add(
        PumpStatus(
          pumpId: 'Pump-2',
          isActive: true,
          flowRate: 12.5,
          pressure: 42.0,
          lastToggled: DateTime.now().subtract(const Duration(minutes: 15)),
          controlMode: 'Auto',
          zone: 'Zone B',
        ),
      );
    });
  }

  Future<void> _handlePumpToggle(int index, bool turnOn) async {
    final pump = _pumps[index];
    final success = await _controlService.togglePump(
      pumpId: pump.pumpId,
      turnOn: turnOn,
    );

    if (success && mounted) {
      setState(() {
        _pumps[index] = pump.copyWith(
          isActive: turnOn,
          lastToggled: DateTime.now(),
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pump ${turnOn ? "activated" : "deactivated"}')),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to control pump')),
      );
    }
  }

  Future<void> _handleModeChange(int index, String mode) async {
    final pump = _pumps[index];
    bool success;
    
    if (mode == 'Auto') {
      success = await _controlService.setAutoMode(pump.pumpId);
    } else {
      success = await _controlService.setManualMode(pump.pumpId);
    }

    if (success && mounted) {
      setState(() {
        _pumps[index] = pump.copyWith(controlMode: mode);
      });
    }
  }

  @override
  void dispose() {
    _telemetryService.dispose();
    _controlService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GreenGrid Dashboard'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          _buildConnectionStatus(),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _initializeData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await _initializeData();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Soil Moisture Sensors'),
                    const SizedBox(height: 8),
                    _buildMoistureSensors(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Water Tank Levels'),
                    const SizedBox(height: 8),
                    _buildTankLevels(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Pump Controls'),
                    const SizedBox(height: 8),
                    _buildPumpControls(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMoistureSensors() {
    if (_sensors.isEmpty) {
      return _buildDemoMoistureSensors();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _sensors.length,
      itemBuilder: (context, index) {
        final sensor = _sensors[index];
        return MoistureGaugeWidget(
          moistureLevel: sensor.moistureLevel,
          location: sensor.location,
          status: sensor.status,
        );
      },
    );
  }

  Widget _buildDemoMoistureSensors() {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      children: const [
        MoistureGaugeWidget(
          moistureLevel: 65.5,
          location: 'Zone A',
          status: 'Safe',
        ),
        MoistureGaugeWidget(
          moistureLevel: 32.0,
          location: 'Zone B',
          status: 'Warning',
        ),
        MoistureGaugeWidget(
          moistureLevel: 15.5,
          location: 'Zone C',
          status: 'Critical',
        ),
        MoistureGaugeWidget(
          moistureLevel: 78.0,
          location: 'Zone D',
          status: 'Safe',
        ),
      ],
    );
  }

  Widget _buildTankLevels() {
    if (_tanks.isEmpty) {
      return _buildDemoTankLevels();
    }

    return Column(
      children: _tanks.map((tank) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TankLevelWidget(
            tankId: tank.tankId,
            levelPercentage: tank.levelPercentage,
            volumeLiters: tank.volumeLiters,
            capacityLiters: tank.capacityLiters,
            status: tank.status,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDemoTankLevels() {
    return const Column(
      children: [
        TankLevelWidget(
          tankId: 'Main Tank',
          levelPercentage: 75.5,
          volumeLiters: 1510,
          capacityLiters: 2000,
          status: 'Normal',
        ),
        SizedBox(height: 12),
        TankLevelWidget(
          tankId: 'Reserve Tank',
          levelPercentage: 25.0,
          volumeLiters: 250,
          capacityLiters: 1000,
          status: 'Low',
        ),
      ],
    );
  }

  Widget _buildPumpControls() {
    return Column(
      children: List.generate(_pumps.length, (index) {
        final pump = _pumps[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: PumpControlWidget(
            pumpId: pump.pumpId,
            zone: pump.zone,
            isActive: pump.isActive,
            controlMode: pump.controlMode,
            flowRate: pump.flowRate,
            pressure: pump.pressure,
            onToggle: (turnOn) => _handlePumpToggle(index, turnOn),
            onModeChange: (mode) => _handleModeChange(index, mode),
          ),
        );
      }),
    );
  }

  Widget _buildConnectionStatus() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _isConnected ? Icons.cloud_done : Icons.cloud_off,
            size: 20,
            color: _isConnected ? Colors.lightGreen[300] : Colors.red[300],
          ),
          const SizedBox(width: 4),
          if (_lastUpdate != null)
            Text(
              _formatLastUpdate(),
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }

  String _formatLastUpdate() {
    if (_lastUpdate == null) return '';
    final diff = DateTime.now().difference(_lastUpdate!);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }
}
