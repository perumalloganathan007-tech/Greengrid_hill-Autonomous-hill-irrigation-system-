import 'package:flutter/material.dart';

/// Widget to display tank level with linear progress bar
class TankLevelWidget extends StatelessWidget {
  final String tankId;
  final double levelPercentage;
  final double volumeLiters;
  final double capacityLiters;
  final String status;

  const TankLevelWidget({
    super.key,
    required this.tankId,
    required this.levelPercentage,
    required this.volumeLiters,
    required this.capacityLiters,
    required this.status,
  });

  Color _getStatusColor() {
    switch (status) {
      case 'Critical':
        return Colors.red;
      case 'Low':
        return Colors.orange;
      case 'Normal':
        return Colors.blue;
      case 'Full':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

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
                Text(
                  tankId,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: levelPercentage / 100,
                minHeight: 30,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor()),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${volumeLiters.toStringAsFixed(0)} L',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${levelPercentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Text(
              'Capacity: ${capacityLiters.toStringAsFixed(0)} L',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
