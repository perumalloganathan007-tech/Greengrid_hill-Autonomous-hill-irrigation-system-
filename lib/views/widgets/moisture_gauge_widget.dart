import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Widget to display soil moisture level with radial gauge
class MoistureGaugeWidget extends StatelessWidget {
  final double moistureLevel;
  final String location;
  final String status;

  const MoistureGaugeWidget({
    super.key,
    required this.moistureLevel,
    required this.location,
    required this.status,
  });

  Color _getStatusColor() {
    switch (status) {
      case 'Critical':
        return Colors.red;
      case 'Warning':
        return Colors.orange;
      case 'Safe':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case 'Critical':
        return Icons.water_drop_outlined;
      case 'Warning':
        return Icons.warning_amber_rounded;
      case 'Safe':
        return Icons.check_circle_outline;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    
    return Container(
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
              location.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showTicks: false,
                    showLabels: true,
                    labelOffset: 12,
                    axisLabelStyle: const GaugeTextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.1,
                      thicknessUnit: GaugeSizeUnit.factor,
                      color: Colors.white.withValues(alpha: 0.1),
                      cornerStyle: CornerStyle.bothCurve,
                    ),
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 20,
                        color: Colors.redAccent,
                        startWidth: 0.1,
                        endWidth: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                      GaugeRange(
                        startValue: 20,
                        endValue: 40,
                        color: Colors.orangeAccent,
                        startWidth: 0.1,
                        endWidth: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                      GaugeRange(
                        startValue: 40,
                        endValue: 100,
                        color: const Color(0xFF00E676),
                        startWidth: 0.1,
                        endWidth: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: moistureLevel,
                        width: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: statusColor,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                        animationDuration: 1500,
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
                        value: moistureLevel,
                        needleColor: Colors.white,
                        tailStyle: const TailStyle(
                          length: 0.15,
                          width: 4,
                          color: Colors.white,
                        ),
                        knobStyle: KnobStyle(
                          color: statusColor,
                          knobRadius: 0.08,
                          borderColor: Colors.white,
                          borderWidth: 0.02,
                        ),
                        needleStartWidth: 1,
                        needleEndWidth: 4,
                        needleLength: 0.8,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                        animationDuration: 1500,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${moistureLevel.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                    _getStatusIcon(),
                    color: statusColor,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
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
