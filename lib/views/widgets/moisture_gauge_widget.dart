import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../utils/constants.dart';

/// Widget to display soil moisture level with radial gauge
class MoistureGaugeWidget extends StatelessWidget {
  final double moistureLevel;
  final String location;
  final String status;
  final double? temperature;

  const MoistureGaugeWidget({
    super.key,
    required this.moistureLevel,
    required this.location,
    required this.status,
    this.temperature,
  });

  Color _getStatusColor() {
    final s = status.toUpperCase();
    if (s.contains('CRITICAL')) {
      return Colors.red;
    } else if (s.contains('WARNING')) {
      return Colors.orange;
    } else if (s.contains('SAFE')) {
      return Colors.green;
    }
    return Colors.grey;
  }

  IconData _getStatusIcon() {
    final s = status.toUpperCase();
    if (s.contains('CRITICAL')) {
      return Icons.water_drop_outlined;
    } else if (s.contains('WARNING')) {
      return Icons.warning_amber_rounded;
    } else if (s.contains('SAFE')) {
      return Icons.check_circle_outline;
    }
    return Icons.help_outline;
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(16),
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
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Text(
              location.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showTicks: true,
                    showLabels: true,
                    interval: 10,
                    labelOffset: 2,
                    tickOffset: 2,
                    minorTicksPerInterval: 1,
                    axisLabelStyle: const GaugeTextStyle(
                      color: Colors.white54,
                      fontSize: 7,
                      fontWeight: FontWeight.bold,
                    ),
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.12,
                      thicknessUnit: GaugeSizeUnit.factor,
                      color: Colors.white.withValues(alpha: 0.1),
                      cornerStyle: CornerStyle.bothCurve,
                    ),
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: AppConstants.criticalMoistureLevel,
                        color: Colors.redAccent,
                        startWidth: 0.1,
                        endWidth: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                      GaugeRange(
                        startValue: AppConstants.criticalMoistureLevel,
                        endValue: AppConstants.warningMoistureLevel,
                        color: Colors.orangeAccent,
                        startWidth: 0.1,
                        endWidth: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                      GaugeRange(
                        startValue: AppConstants.warningMoistureLevel,
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
                          knobRadius: 0.05,
                          borderColor: Colors.white,
                          borderWidth: 0.01,
                        ),
                        needleStartWidth: 0.5,
                        needleEndWidth: 2,
                        needleLength: 0.7,
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
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                        angle: 90,
                        positionFactor: 0.45,
                      ),
                      if (temperature != null)
                        GaugeAnnotation(
                          widget: Text(
                            '${temperature!.toStringAsFixed(1)}°C',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                          angle: 90,
                          positionFactor: 0.15,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: statusColor.withValues(alpha: 0.8),
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getStatusIcon(),
                    color: statusColor,
                    size: 10,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      status.toUpperCase(),
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 8,
                        letterSpacing: 0.8,
                      ),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
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
