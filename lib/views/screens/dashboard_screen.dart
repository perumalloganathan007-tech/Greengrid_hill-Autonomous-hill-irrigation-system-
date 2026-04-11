import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../../models/sensor_data.dart';
import '../../models/pump_status.dart';
import '../../models/plant_profile.dart';
import '../../models/terrace_data.dart';
import '../../services/telemetry_service.dart';
import '../../services/control_service.dart';
import '../../services/notification_service.dart';
import '../../services/smart_irrigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/preferences_service.dart';
import '../../utils/constants.dart';
import '../widgets/network_status_indicator.dart';
import '../widgets/moisture_gauge_widget.dart';
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
    _smartIrrigationService = SmartIrrigationService(_controlService, _notificationService);
    _initializeData();
    _notificationService.initialize();
  }

  Future<void> _initializeData() async {
    setState(() {
      _isLoading = true;
    });

    final esp32Url = await _prefsService.getEsp32Url();
    _controlService = ControlService(esp32BaseUrl: esp32Url);
    _smartIrrigationService = SmartIrrigationService(_controlService, _notificationService);

    // Initial pump setup will now wait for telemetry to define the sensor count
    setState(() {
      _pumps.clear();
    });

    // Start real-time monitoring
    _telemetryService.startSensorMonitoring();

    // Listen to sensor stream
    _telemetryService.sensorDataStream.listen((sensors) {
      if (mounted) {
        setState(() {
          _sensors = sensors;
          _isLoading = false;
          _lastUpdateTime = DateTime.now();
          
          // Dynamically synchronize the number of pumps with the number of sensors
          // This ensures that "three soil moisture widget = three terrace in valve control"
          final List<PumpStatus> syncedPumps = [];
          for (int i = 0; i < sensors.length; i++) {
            final pumpId = 'pump_${i + 1}';
            final sensor = sensors[i];
            
            // Attempt to preserve existing pump status if already known
            final existingIndex = _pumps.indexWhere((p) => p.pumpId == pumpId);
            if (existingIndex != -1) {
              syncedPumps.add(_pumps[existingIndex].copyWith(zone: sensor.location));
            } else {
              syncedPumps.add(PumpStatus(
                pumpId: pumpId,
                isActive: false,
                flowRate: 0.0,
                pressure: 0.0,
                lastToggled: DateTime.now(),
                controlMode: 'Auto',
                zone: sensor.location,
              ));
            }
          }
          
          _pumps.clear();
          _pumps.addAll(syncedPumps);
        });

        // Fetch actual status for the newly synced pumps
        _loadPumpData();

        // Check for alerts
        _notificationService.checkSensorAlerts(sensors);
        
        // Auto-pump logic using SmartIrrigationService
        _checkAutoIrrigation();
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
    if (_pumps.isEmpty) return;

    try {
      final List<Future<PumpStatus?>> futures = [];
      for (int i = 0; i < _pumps.length; i++) {
        futures.add(_controlService.getPumpStatus(_pumps[i].pumpId));
      }

      final results = await Future.wait(futures);
      final List<PumpStatus> updatedPumps = [];
      
      for (int i = 0; i < _pumps.length; i++) {
        final pump = _pumps[i];
        final status = results[i];
        
        updatedPumps.add(status ?? 
          PumpStatus(
            pumpId: pump.pumpId,
            isActive: pump.isActive,
            flowRate: pump.flowRate,
            pressure: pump.pressure,
            lastToggled: pump.lastToggled,
            controlMode: pump.controlMode,
            zone: pump.zone,
          )
        );
      }

      if (mounted) {
        setState(() {
          _pumps.clear();
          _pumps.addAll(updatedPumps);
        });
      }
    } catch (e) {
      debugPrint('Error loading pump data: $e');
    }
  }

  Future<void> _setPumpMode(int index, String mode) async {
    final pump = _pumps[index];
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      // When switching to Manual, ensure the valve starts in the OFF state for safety
      final bool newIsActive = (mode == 'Manual') ? false : pump.isActive;
      _pumps[index] = pump.copyWith(controlMode: mode, isActive: newIsActive);
    });

    try {
      if (mode == 'Auto') {
        await _controlService.setAutoMode(pump.pumpId);
      } else {
        await _controlService.setManualMode(pump.pumpId);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.setMode(pump.zone, mode)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            backgroundColor: const Color(0xFF2E7D32),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error setting pump mode: $e');
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
          content: Text(turnOn ? AppLocalizations.of(context)!.valveActivated : AppLocalizations.of(context)!.valveDeactivated),
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
        title: Text(AppLocalizations.of(context)!.dashboard, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF388E3C), // Emerald Green
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
                   Text(
                    AppLocalizations.of(context)!.lastSync.toUpperCase(),
                    style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white54),
                  ),
                  Text(
                    DateFormat('HH:mm:ss').format(_lastUpdateTime!),
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
                double aspectRatio = 1.1;

                if (width < 350) {
                  crossAxisCount = 1;
                  aspectRatio = 1.8;
                } else if (width > 900) {
                  crossAxisCount = 3;
                  aspectRatio = 1.2;
                } else if (width > 1400) {
                  crossAxisCount = 4;
                  aspectRatio = 1.4;
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
                        _buildSectionHeader(AppLocalizations.of(context)!.soilMoistureSensors),
                        const SizedBox(height: 16),
                        _buildMoistureGrid(crossAxisCount, aspectRatio),
                        const SizedBox(height: 32),
                        _buildSectionHeader(AppLocalizations.of(context)!.valveControls),
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
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(AppLocalizations.of(context)!.noSensorsFound, style: const TextStyle(color: Colors.white54)),
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
        String status = AppLocalizations.of(context)!.statusSafe;
        if (sensor.moistureLevel < AppConstants.criticalMoistureLevel) {
          status = AppLocalizations.of(context)!.statusCritical;
        } else if (sensor.moistureLevel < AppConstants.warningMoistureLevel) {
          status = AppLocalizations.of(context)!.statusWarning;
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

  Widget _buildValveControls() {
    if (_pumps.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(AppLocalizations.of(context)!.noValvesAvailable, style: const TextStyle(color: Colors.white54)),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Valve Cards
        ...List.generate(_pumps.length, (index) {
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
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.autoMode,
                          style: TextStyle(
                            color: pump.controlMode == 'Auto' ? Colors.green.shade300 : Colors.white38,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Transform.scale(
                            scale: 0.7,
                            child: Switch(
                              value: pump.controlMode == 'Auto',
                              onChanged: (isAuto) => _setPumpMode(index, isAuto ? 'Auto' : 'Manual'),
                              activeTrackColor: Colors.green.withValues(alpha: 0.3),
                              activeThumbColor: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      pump.controlMode == 'Auto' 
                          ? AppLocalizations.of(context)!.statusAutomatic 
                          : (pump.isActive ? AppLocalizations.of(context)!.statusManualOn : AppLocalizations.of(context)!.statusSystemOff),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: pump.controlMode == 'Auto' 
                            ? Colors.green.shade400 
                            : (pump.isActive ? Colors.orange.shade400 : Colors.red.shade400),
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.manualMode,
                      style: TextStyle(
                        color: pump.controlMode == 'Manual' ? Colors.orange.shade300 : Colors.white24,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: pump.isActive,
                      onChanged: pump.controlMode == 'Manual' 
                        ? (val) => _handlePumpToggle(index, val)
                        : null, // Disable switches if in Auto mode
                      activeTrackColor: Colors.green.withValues(alpha: 0.3),
                      activeThumbColor: Colors.green,
                    ),
                  ],
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
      ],
    );
  }
}
