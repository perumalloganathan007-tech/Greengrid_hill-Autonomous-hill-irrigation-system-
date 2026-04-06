import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

/// A reusable widget that provides a real-time, animated connection status indicator.
/// Monitors Firebase database connectivity and provides a pulsing glow effect when online.
class NetworkStatusIndicator extends StatefulWidget {
  const NetworkStatusIndicator({super.key});

  @override
  State<NetworkStatusIndicator> createState() => _NetworkStatusIndicatorState();
}

class _NetworkStatusIndicatorState extends State<NetworkStatusIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Stream<DatabaseEvent> _connectedStream;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _connectedStream = FirebaseDatabase.instance.ref('.info/connected').onValue;
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: _connectedStream,
      builder: (context, snapshot) {
        final isConnected = snapshot.data?.snapshot.value == true;
        
        return Tooltip(
          message: isConnected ? 'Server Connected' : 'Server Disconnected',
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: isConnected ? _buildOnlineIcon() : _buildOfflineIcon(),
          ),
        );
      },
    );
  }

  Widget _buildOnlineIcon() {
    return AnimatedBuilder(
      key: const ValueKey('online'),
      animation: _pulseController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer pulse glow
            Transform.scale(
              scale: 1.0 + (_pulseController.value * 0.4),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF00E676).withValues(alpha: 0.15 * (1.0 - _pulseController.value)),
                ),
              ),
            ),
            // Inner pulsing dot
            Opacity(
              opacity: 0.3 + (_pulseController.value * 0.4),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF00E676).withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.cloud_done,
              color: Color(0xFF00E676),
              size: 20,
            ),
          ],
        );
      },
    );
  }

  Widget _buildOfflineIcon() {
    return const Icon(
      key: ValueKey('offline'),
      Icons.cloud_off,
      color: Color(0xFFFF1744),
      size: 20,
    );
  }
}
