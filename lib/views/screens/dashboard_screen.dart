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
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/preferences_service.dart';
import '../widgets/network_status_indicator.dart';

/// Main dashboard screen displaying real-time telemetry and controls
class DashboardScreen extends StatefulWidget {
  final String? userId;

  const DashboardScreen({super.key, this.userId});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final TelemetryService _telemetryService = TelemetryService(
    userId: widget.userId ?? FirebaseAuth.instance.currentUser?.uid ?? 'test_user',
  );
  late ControlService _controlService;
  final PreferencesService _prefsService = PreferencesService();
  final NotificationService _notificationService = NotificationService();

  List<SensorData> _sensors = [];
  List<TankLevel> _tanks = [];
  final List<PumpStatus> _pumps = [];
  bool _isLoading = true;
  DateTime? _lastUpdateTime;

  @override
  void initState() {
    super.initState();
    _controlService = ControlService(esp32BaseUrl: 'http://192.168.1.100'); // Default
    _initializeData();
    _notificationService.initialize();
  }

  Future<void> _initializeData() async {
    setState(() {
      _isLoading = true;
    });

    final esp32Url = await _prefsService.getEsp32Url();
    _controlService = ControlService(esp32BaseUrl: esp32Url);

    // Initial pre-population of pumps to avoid race conditions with telemetry
    setState(() {
      _pumps.clear();
      for (int i = 0; i < 4; i++) {
        _pumps.add(PumpStatus(
          pumpId: 'pump_${i + 1}',
          isActive: false,
          flowRate: 0.0,
          pressure: 0.0,
          lastToggled: DateTime.now(),
          controlMode: 'Auto',
          zone: 'Terrace Zone ${i + 1}',
        ));
      }
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
          _lastUpdateTime = DateTime.now();
        });
        // Check for alerts
        _notificationService.checkSensorAlerts(sensors);
        
        // Auto-pump logic
        _checkAutoIrrigation();
      }
    });

    // Listen to tank stream
    _telemetryService.tankLevelStream.listen((tanks) {
      if (mounted) {
        setState(() {
          _tanks = tanks;
          _lastUpdateTime = DateTime.now();
        });
        // Check for tank alerts
        _notificationService.checkTankAlerts(tanks);
      }
    });

    // Load initial pump data
    _loadPumpData();
    
    // Fallback if data loading takes too long or fails
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && _isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _checkAutoIrrigation() {
    if (_sensors.isEmpty || _pumps.isEmpty) return;

    for (final sensor in _sensors) {
      if (sensor.moistureLevel < 30) {
        // Extract zone number from location (e.g., "Terrace Zone 1" -> "1")
        final zoneMatch = RegExp(r'Zone (\d+)').firstMatch(sensor.location);
        if (zoneMatch != null) {
          final zoneNum = zoneMatch.group(1);
          // Find matching pump for this zone
          final pumpIndex = _pumps.indexWhere((p) => p.pumpId == 'pump_$zoneNum');
          
          if (pumpIndex != -1) {
            final pump = _pumps[pumpIndex];
            // Only auto-trigger if in Auto mode and currently off
            if (pump.controlMode == 'Auto' && !pump.isActive) {
              _handlePumpToggle(pumpIndex, true);
              debugPrint('Auto-triggering ${pump.pumpId} due to low moisture (${sensor.moistureLevel}%)');
            }
          }
        }
      }
    }
  }

  Future<void> _loadPumpData() async {
    // Attempt to fetch actual pump status from ESP32 for all defined pumps
    try {
      final List<Future<PumpStatus?>> futures = [];
      for (int i = 0; i < 4; i++) {
        futures.add(_controlService.getPumpStatus('pump_${i + 1}'));
      }

      final results = await Future.wait(futures);
      final List<PumpStatus> updatedPumps = [];
      
      for (int i = 0; i < 4; i++) {
        final pumpId = 'pump_${i + 1}';
        final zoneName = 'Terrace Zone ${i + 1}';
        final status = results[i];
        
        updatedPumps.add(status ?? 
          PumpStatus(
            pumpId: pumpId,
            isActive: false,
            flowRate: 0.0,
            pressure: 0.0,
            lastToggled: DateTime.now(),
            controlMode: 'Auto',
            zone: zoneName,
          )
        );
      }

      if (mounted) {
        setState(() {
          _pumps.clear();
          _pumps.addAll(updatedPumps);
        });
        // Re-check auto-irrigation after hardware status is finalized
        _checkAutoIrrigation();
      }
    } catch (e) {
      debugPrint('Error loading pump data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ESP32 Connection Timeout. Check IP in Settings.')),
        );
      }
    }
  }

  Future<void> _handlePumpToggle(int index, bool turnOn) async {
    final pump = _pumps[index];
    // Ignore success result for UI demonstration when ESP32 is offline
    await _controlService.togglePump(
      pumpId: pump.pumpId,
      turnOn: turnOn,
    );

    if (mounted) {
      setState(() {
        _pumps[index] = pump.copyWith(
          isActive: turnOn,
          lastToggled: DateTime.now(),
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Valve ${turnOn ? "activated" : "deactivated"} (Simulated)')),
      );
    }
  }

  Future<void> _handleModeChange(int index, String mode) async {
    final pump = _pumps[index];
    
    if (mode == 'Auto') {
      await _controlService.setAutoMode(pump.pumpId);
    } else {
      await _controlService.setManualMode(pump.pumpId);
    }

    if (mounted) {
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
          if (_lastUpdateTime != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   const Text(
                    'LAST SYNC',
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white54),
                  ),
                  Text(
                    '${_lastUpdateTime!.hour.toString().padLeft(2, '0')}:${_lastUpdateTime!.minute.toString().padLeft(2, '0')}:${_lastUpdateTime!.second.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 12),
          const NetworkStatusIndicator(),
          const SizedBox(width: 8),
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
                    _buildSectionHeader('Valve Controls'),
                    const SizedBox(height: 8),
                    _buildPumpControls(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoistureSensors() {
    if (_sensors.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sensors_off, size: 48, color: Colors.green.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            const Text(
              'Currently no data is available',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double childAspectRatio;
        
        // Responsive breakpoints
        if (constraints.maxWidth >= 1200) {
          crossAxisCount = 4;
          childAspectRatio = 1.1;
        } else if (constraints.maxWidth >= 800) {
          crossAxisCount = 3;
          childAspectRatio = 1.0;
        } else if (constraints.maxWidth >= 600) {
          crossAxisCount = 2;
          childAspectRatio = 1.0;
        } else {
          crossAxisCount = 2;
          childAspectRatio = 0.85;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
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
      },
    );
  }

  Widget _buildTankLevels() {
    if (_tanks.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('Data is not initialized or no tanks found.'),
        ),
      );
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

  Widget _buildPumpControls() {
    if (_pumps.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('Initializing valves...'),
        ),
      );
    }

    if (_sensors.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Valve controls unavailable - No sensors matched.',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    // Only show as many valves as we have active sensors
    final activePumpCount = _sensors.length;
    
    return Column(
      children: List.generate(activePumpCount, (index) {
        // Ensure we don't go out of bounds if _pumps is smaller than _sensors
        if (index >= _pumps.length) return const SizedBox.shrink();
        
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


}
