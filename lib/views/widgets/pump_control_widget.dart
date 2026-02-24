import 'package:flutter/material.dart';

/// Widget for pump control with manual override
class PumpControlWidget extends StatefulWidget {
  final String pumpId;
  final String zone;
  final bool isActive;
  final String controlMode;
  final double flowRate;
  final double pressure;
  final Function(bool) onToggle;
  final Function(String) onModeChange;

  const PumpControlWidget({
    super.key,
    required this.pumpId,
    required this.zone,
    required this.isActive,
    required this.controlMode,
    required this.flowRate,
    required this.pressure,
    required this.onToggle,
    required this.onModeChange,
  });

  @override
  State<PumpControlWidget> createState() => _PumpControlWidgetState();
}

class _PumpControlWidgetState extends State<PumpControlWidget> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pumpId,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.zone,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: widget.isActive ? Colors.green.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.isActive ? 'ON' : 'OFF',
                    style: TextStyle(
                      color: widget.isActive ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    'Flow Rate',
                    '${widget.flowRate.toStringAsFixed(1)} L/min',
                    Icons.water_drop,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildInfoCard(
                    'Pressure',
                    '${widget.pressure.toStringAsFixed(1)} PSI',
                    Icons.speed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'Auto', label: Text('Auto')),
                      ButtonSegment(value: 'Manual Override', label: Text('Manual')),
                    ],
                    selected: {widget.controlMode},
                    onSelectionChanged: (Set<String> selected) {
                      widget.onModeChange(selected.first);
                    },
                  ),
                ),
              ],
            ),
            if (widget.controlMode == 'Manual Override') ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isProcessing
                      ? null
                      : () async {
                          setState(() => _isProcessing = true);
                          await widget.onToggle(!widget.isActive);
                          if (mounted) {
                            setState(() => _isProcessing = false);
                          }
                        },
                  icon: _isProcessing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Icon(widget.isActive ? Icons.power_off : Icons.power),
                  label: Text(
                    _isProcessing
                        ? 'Processing...'
                        : (widget.isActive ? 'Turn OFF' : 'Turn ON'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.isActive ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
