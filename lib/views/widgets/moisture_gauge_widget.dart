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
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              location,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 20,
                        color: Colors.red,
                        label: 'Critical',
                      ),
                      GaugeRange(
                        startValue: 20,
                        endValue: 40,
                        color: Colors.orange,
                        label: 'Warning',
                      ),
                      GaugeRange(
                        startValue: 40,
                        endValue: 100,
                        color: Colors.green,
                        label: 'Safe',
                      ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: moistureLevel,
                        needleColor: _getStatusColor(),
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          '${moistureLevel.toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getStatusIcon(),
                  color: _getStatusColor(),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getStatusColor(),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
