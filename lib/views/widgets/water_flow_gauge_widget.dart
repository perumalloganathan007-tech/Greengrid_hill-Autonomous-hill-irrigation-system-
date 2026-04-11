import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Widget to display real-time water flow rate with radial gauge
class WaterFlowGaugeWidget extends StatelessWidget {
  final double flowRate; // Liters per minute
  final String pumpId;
  final bool isActive;

  const WaterFlowGaugeWidget({
    super.key,
    required this.flowRate,
    required this.pumpId,
    required this.isActive,
  });

  Color _getStatusColor() {
    if (!isActive) return Colors.grey;
    if (flowRate > 40) return Colors.redAccent;
    if (flowRate > 30) return Colors.orangeAccent;
    return Colors.blueAccent;
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final String statusText = isActive 
        ? (flowRate > 0 ? 'Flowing' : 'Pump On / No Flow')
        : 'Standby';
    
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'WATER FLOW RATE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pumpId.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
            Expanded(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 50,
                    showTicks: true,
                    showLabels: true,
                    labelOffset: 12,
                    interval: 10,
                    axisLabelStyle: const GaugeTextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.08,
                      thicknessUnit: GaugeSizeUnit.factor,
                      color: Colors.white.withValues(alpha: 0.1),
                      cornerStyle: CornerStyle.bothCurve,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: flowRate,
                        width: 0.08,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: statusColor,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                        animationDuration: 1000,
                        gradient: SweepGradient(
                          colors: [
                            statusColor.withValues(alpha: 0.3),
                            statusColor,
                          ],
                          stops: const [0.2, 1.0],
                        ),
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                      NeedlePointer(
                        value: flowRate,
                        needleColor: Colors.white,
                        tailStyle: const TailStyle(
                          length: 0.15,
                          width: 4,
                          color: Colors.white,
                        ),
                        knobStyle: KnobStyle(
                          color: statusColor,
                          knobRadius: 0.07,
                          borderColor: Colors.white,
                          borderWidth: 0.02,
                        ),
                        needleStartWidth: 1,
                        needleEndWidth: 3,
                        needleLength: 0.75,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              flowRate.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: -1,
                              ),
                            ),
                            const Text(
                              'L/min',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                        angle: 90,
                        positionFactor: 0.6,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: statusColor.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isActive ? Icons.water_drop : Icons.pause_circle_outline,
                    color: statusColor,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    statusText.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
