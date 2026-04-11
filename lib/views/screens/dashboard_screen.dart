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
import '../widgets/moisture_gauge_widget.dart';
import '../widgets/tank_level_widget.dart';
import '../widgets/pump_control_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/preferences_service.dart';
import '../widgets/network_status_indicator.dart';

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
      backgroundColor: const Color(0xFFF1F8E9), // Eco-friendly Light Green BG
      appBar: AppBar(
        title: const Text('GreenGrid Hill', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1B5E20), // Forest Green
        foregroundColor: Colors.white,
        elevation: 0,
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
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF1B5E20)))
          : RefreshIndicator(
              color: const Color(0xFF1B5E20),
              onRefresh: () async {
                await _initializeData();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOverviewCard(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Terrace Insights & Control'),
                    const SizedBox(height: 8),
                    _buildTerraceEnvironment(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.eco, color: Color(0xFF1B5E20), size: 28),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _defaultPlant.plantName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniStat('Target Moose', '${_defaultPlant.minMoisture}% - ${_defaultPlant.maxMoisture}%', Icons.water_drop, const Color(0xFF26C6DA)),
              _buildMiniStat('Pref. Temp', '${_defaultPlant.optimalTemperature}°C', Icons.thermostat, const Color(0xFFFFD54F)),
            ],
          ),
          const SizedBox(height: 16),
          // Integrating overall tank state
          if (_tanks.isNotEmpty)
            Row(
              children: [
                const Icon(Icons.waves, color: Color(0xFF26C6DA)),
                const SizedBox(width: 8),
                Text(
                  'Main Tank Reserve: ${_tanks.first.levelPercentage.toStringAsFixed(1)}%',
                  style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF1B5E20), // Forest Green
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              color: Color(0xFF1B5E20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerraceEnvironment() {
    if (_sensors.isEmpty) {
      return Center(
        child: Text(
          'No terrace data available.',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      );
    }

    return Column(
      children: List.generate(_sensors.length, (index) {
        final sensor = _sensors[index];
        
        final zoneMatch = RegExp(r'Zone (\d+)').firstMatch(sensor.location);
        final zoneNum = zoneMatch != null ? int.parse(zoneMatch.group(1)!) : (index + 1);
        
        // Find corresponding pump
        final pumpIndex = _pumps.indexWhere((p) => p.pumpId == 'pump_$zoneNum');
        final pump = pumpIndex != -1 ? _pumps[pumpIndex] : null;

        // Calculate Terrace Gradient Color based on depth (Top -> Bottom)
        // Top = Light Brown (#D7CCC8), Bottom = Dark Brown (#8D6E63)
        final double gradientRatio = (zoneNum - 1) / 3.0; // Assuming up to 4 terraces
        final Color terraceColor = Color.lerp(
          const Color(0xFFD7CCC8), // Light Earth
          const Color(0xFF8D6E63), // Darker Earth
          gradientRatio.clamp(0.0, 1.0),
        )!;

        // Determine if water is needed textually
        final bool waterNeeded = sensor.moistureLevel < _defaultPlant.minMoisture;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [terraceColor.withValues(alpha: 0.2), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: terraceColor.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Terrace Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.landscape, color: terraceColor.withOpacity(1.0)),
                      const SizedBox(width: 8),
                      Text(
                        'Terrace Level $zoneNum',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: waterNeeded ? Colors.red.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      waterNeeded ? 'Needs Water' : 'Hydrated',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: waterNeeded ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Key Metrics
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildEnvironmentPill(
                    icon: Icons.water_drop,
                    value: '${sensor.moistureLevel.toStringAsFixed(1)}%',
                    label: 'Moisture',
                    color: const Color(0xFF26C6DA), // Aqua
                  ),
                  _buildEnvironmentPill(
                    icon: Icons.thermostat,
                    value: sensor.temperature != null ? '${sensor.temperature!.toStringAsFixed(1)}°C' : 'N/A',
                    label: 'Temp',
                    color: const Color(0xFFFFD54F), // Soft Yellow
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              
              // Pump Controls
              if (pump != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Valve Control', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                        Text('Mode: ${pump.controlMode}', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                      ],
                    ),
                    Switch(
                      value: pump.isActive,
                      activeColor: const Color(0xFF1B5E20), // Forest Green
                      onChanged: (val) {
                        if (pumpIndex != -1) {
                          _handlePumpToggle(pumpIndex, val);
                        }
                      },
                    ),
                  ],
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildEnvironmentPill({required IconData icon, required String value, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
