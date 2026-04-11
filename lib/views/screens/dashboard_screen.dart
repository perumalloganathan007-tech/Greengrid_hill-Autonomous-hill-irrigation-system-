import 'package:flutter/material.dart';
import '../../models/sensor_data.dart';
import '../../models/tank_level.dart';
import '../../models/pump_status.dart';
import '../../models/plant_profile.dart';
import '../../models/terrace_data.dart';
import '../../services/telemetry_service.dart';
import '../../services/control_service.dart';
import '../../services/notification_service.dart';
import '../../services/smart_irrigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/preferences_service.dart';
import '../widgets/network_status_indicator.dart';
import '../widgets/moisture_gauge_widget.dart';
import '../widgets/tank_level_widget.dart';
import '../widgets/water_flow_gauge_widget.dart';

/// Main dashboard screen displaying real-time telemetry and controls
/// Refactored for Eco-Friendly Aesthetic & Terrace Logic
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
  late SmartIrrigationService _smartIrrigationService;
  final PreferencesService _prefsService = PreferencesService();
  final NotificationService _notificationService = NotificationService();

  List<SensorData> _sensors = [];
  List<TankLevel> _tanks = [];
  final List<PumpStatus> _pumps = [];
  bool _isLoading = true;
  DateTime? _lastUpdateTime;

  // Mocked default plant profile
  final PlantProfile _defaultPlant = const PlantProfile(
    plantName: 'Terrace Tea (Camellia Sinensis)',
    minMoisture: 30.0,
    maxMoisture: 70.0,
    optimalTemperature: 24.0,
    baseWaterDuration: Duration(minutes: 2), // 120 seconds
  );

  @override
  void initState() {
    super.initState();
    _controlService = ControlService(esp32BaseUrl: 'http://192.168.1.100'); // Default
    _smartIrrigationService = SmartIrrigationService(_controlService);
    _initializeData();
    _notificationService.initialize();
  }

  Future<void> _initializeData() async {
    setState(() {
      _isLoading = true;
    });

    final esp32Url = await _prefsService.getEsp32Url();
    _controlService = ControlService(esp32BaseUrl: esp32Url);
    _smartIrrigationService = SmartIrrigationService(_controlService);

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
        
        // Auto-pump logic using SmartIrrigationService
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
      final zoneMatch = RegExp(r'Zone (\d+)').firstMatch(sensor.location);
      if (zoneMatch != null) {
        final zoneNumStr = zoneMatch.group(1);
        final zoneNum = int.tryParse(zoneNumStr ?? '1') ?? 1;
        
        // Find matching pump for this zone
        final pumpIndex = _pumps.indexWhere((p) => p.pumpId == 'pump_$zoneNum');
        
        if (pumpIndex != -1) {
          final pump = _pumps[pumpIndex];
          // Only auto-trigger if in Auto mode
          if (pump.controlMode == 'Auto') {
            final terraceData = TerraceData(
              terraceLevel: zoneNum,
              zoneName: sensor.location,
              slopeFactor: 1.0,
            );
            
            _smartIrrigationService.evaluateAndTrigger(
              sensorData: sensor,
              plantProfile: _defaultPlant,
              terrace: terraceData,
              pumpId: pump.pumpId,
            );
          }
        }
      }
    }
  }

  Future<void> _loadPumpData() async {
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
        _checkAutoIrrigation();
      }
    } catch (e) {
      debugPrint('Error loading pump data: $e');
    }
  }

  Future<void> _handlePumpToggle(int index, bool turnOn) async {
    final pump = _pumps[index];
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
        SnackBar(
          content: Text('Valve ${turnOn ? "activated" : "deactivated"}'),
          backgroundColor: const Color(0xFF1B5E20),
        ),
      );
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
      backgroundColor: const Color(0xFF121212), // Material Dark BG
      appBar: AppBar(
        title: const Text('GreenGrid Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2E7D32), // Emerald Green
        foregroundColor: Colors.white,
        elevation: 4,
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
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF4CAF50)))
          : LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;
                int crossAxisCount = 2;
                double aspectRatio = 0.85;

                if (width < 350) {
                  crossAxisCount = 1;
                  aspectRatio = 1.4;
                } else if (width > 900) {
                  crossAxisCount = 3;
                  aspectRatio = 0.9;
                } else if (width > 1400) {
                  crossAxisCount = 4;
                  aspectRatio = 1.0;
                }

                return RefreshIndicator(
                  color: const Color(0xFF4CAF50),
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
                        const SizedBox(height: 16),
                        _buildMoistureGrid(crossAxisCount, aspectRatio),
                        const SizedBox(height: 32),
                        _buildSectionHeader('Water Tank Levels'),
                        const SizedBox(height: 16),
                        _buildTankLevels(),
                        const SizedBox(height: 32),
                        _buildSectionHeader('Valve Controls'),
                        const SizedBox(height: 16),
                        _buildValveControls(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildMoistureGrid(int crossAxisCount, double aspectRatio) {
    if (_sensors.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text('Data is not initialized or no sensors found.', style: TextStyle(color: Colors.white54)),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: aspectRatio,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: _sensors.length,
      itemBuilder: (context, index) {
        final sensor = _sensors[index];
        String status = 'Safe';
        if (sensor.moistureLevel < 20) {
          status = 'Critical';
        } else if (sensor.moistureLevel < 40) {
          status = 'Warning';
        }

        return MoistureGaugeWidget(
          moistureLevel: sensor.moistureLevel,
          location: sensor.location,
          status: status,
          temperature: sensor.temperature,
        );
      },
    );
  }

  Widget _buildTankLevels() {
    if (_tanks.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text('Data is not initialized or no tanks found.', style: TextStyle(color: Colors.white54)),
        ),
      );
    }

    return Column(
      children: _tanks.map((tank) {
        String status = 'Normal';
        if (tank.levelPercentage < 15) {
          status = 'Critical';
        } else if (tank.levelPercentage < 30) {
          status = 'Low';
        } else if (tank.levelPercentage > 90) {
          status = 'Full';
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TankLevelWidget(
            tankId: tank.tankId,
            levelPercentage: tank.levelPercentage,
            volumeLiters: tank.volumeLiters,
            capacityLiters: tank.capacityLiters,
            status: status,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildValveControls() {
    if (_pumps.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text('No valves available.', style: TextStyle(color: Colors.white54)),
        ),
      );
    }

    return Column(
      children: List.generate(_pumps.length, (index) {
        final pump = _pumps[index];
        return Card(
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.settings_input_component,
                  color: pump.isActive ? Colors.green : Colors.grey,
                ),
                title: Text(
                  pump.zone,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Mode: ${pump.controlMode}',
                  style: const TextStyle(color: Colors.white54),
                ),
                trailing: Switch(
                  value: pump.isActive,
                  onChanged: (val) => _handlePumpToggle(index, val),
                  activeTrackColor: Colors.green.withValues(alpha: 0.3),
                  activeThumbColor: Colors.green,
                ),
              ),
              if (pump.isActive)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: WaterFlowGaugeWidget(
                    flowRate: pump.flowRate,
                    pumpId: pump.pumpId,
                    isActive: pump.isActive,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
