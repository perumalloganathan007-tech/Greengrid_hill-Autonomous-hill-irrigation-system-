import 'package:flutter/material.dart';
import 'constants.dart';

/// Utility helper functions
class AppHelpers {
  /// Get status color based on status string
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'critical':
        return const Color(AppConstants.colorCritical);
      case 'warning':
        return const Color(AppConstants.colorWarning);
      case 'safe':
        return const Color(AppConstants.colorSafe);
      case 'normal':
        return const Color(AppConstants.colorNormal);
      case 'full':
        return const Color(AppConstants.colorSafe);
      case 'low':
        return const Color(AppConstants.colorWarning);
      default:
        return Colors.grey;
    }
  }
  
  /// Format liters to readable string
  static String formatLiters(double liters) {
    if (liters >= 1000) {
      return '${(liters / 1000).toStringAsFixed(1)}K L';
    }
    return '${liters.toStringAsFixed(0)} L';
  }
  
  /// Format percentage to readable string
  static String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(1)}%';
  }
  
  /// Format flow rate
  static String formatFlowRate(double flowRate) {
    return '${flowRate.toStringAsFixed(1)} L/min';
  }
  
  /// Format pressure
  static String formatPressure(double pressure) {
    return '${pressure.toStringAsFixed(1)} PSI';
  }
  
  /// Validate IP address format
  static bool isValidIpAddress(String ip) {
    final ipRegex = RegExp(
      r'^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$',
    );
    
    if (!ipRegex.hasMatch(ip)) return false;
    
    final parts = ip.split('.');
    for (var part in parts) {
      final num = int.tryParse(part);
      if (num == null || num < 0 || num > 255) return false;
    }
    
    return true;
  }
  
  /// Validate URL format
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
  
  /// Get moisture status from level
  static String getMoistureStatus(double level) {
    if (level < AppConstants.criticalMoistureLevel) {
      return 'Critical';
    } else if (level < AppConstants.warningMoistureLevel) {
      return 'Warning';
    } else {
      return 'Safe';
    }
  }
  
  /// Get tank status from level percentage
  static String getTankStatus(double percentage) {
    if (percentage >= AppConstants.tankFullLevel) {
      return 'Full';
    } else if (percentage >= AppConstants.tankNormalLevel) {
      return 'Normal';
    } else if (percentage >= AppConstants.tankLowLevel) {
      return 'Low';
    } else {
      return 'Critical';
    }
  }
  
  /// Show snackbar with message
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
  
  /// Show confirmation dialog
  static Future<bool> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }
  
  /// Calculate water savings percentage
  static double calculateSavingsPercentage(double used, double saved) {
    final total = used + saved;
    if (total == 0) return 0.0;
    return (saved / total) * 100;
  }
  
  /// Format date to readable string
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
  
  /// Format time to readable string
  static String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
  
  /// Get time ago string
  static String getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}
