import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/environment_data.dart';
import 'package:intl/intl.dart';

/// Widget to display system-wide ambient environment data (DHT22)
class EnvironmentCardWidget extends StatelessWidget {
  final EnvironmentData? environmentData;

  const EnvironmentCardWidget({
    super.key,
    this.environmentData,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    final bool hasData = environmentData != null;
    final tempColor = hasData ? _getTemperatureColor(environmentData!.temperature) : Colors.grey;
    final humColor = hasData ? Colors.lightBlueAccent : Colors.grey;
    final tempString = hasData ? '${environmentData!.temperature.toStringAsFixed(1)}°C' : '-- °C';
    final humString = hasData ? '${environmentData!.humidity.toStringAsFixed(1)}%' : '-- %';
    final timeString = hasData ? DateFormat('HH:mm').format(environmentData!.timestamp) : l10n.waitingForSensor;

    return Card(
      color: const Color(0xFF161616),
      elevation: 8,
      shadowColor: tempColor.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.thermostat, color: tempColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      l10n.systemEnvironment.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Text(
                  timeString,
                  style: const TextStyle(fontSize: 10, color: Colors.white38),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildMetric(
                    label: l10n.temperature,
                    value: tempString,
                    icon: Icons.wb_sunny_outlined,
                    color: tempColor,
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.white12,
                ),
                Expanded(
                  child: _buildMetric(
                    label: l10n.humidity,
                    value: humString,
                    icon: Icons.water_drop_outlined,
                    color: humColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color.withValues(alpha: 0.8), size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getTemperatureColor(double temp) {
    if (temp > 35) return Colors.redAccent;
    if (temp > 28) return Colors.orangeAccent;
    if (temp < 10) return Colors.blueAccent;
    return const Color(0xFF00E676); // Safe Green
  }
}
