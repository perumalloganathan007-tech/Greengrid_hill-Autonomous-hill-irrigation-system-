import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Settings screen for app configuration
class SettingsScreen extends StatefulWidget {
  final Function(ThemeMode)? onThemeChanged;
  
  const SettingsScreen({super.key, this.onThemeChanged});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _esp32UrlController = TextEditingController();
  bool _notificationsEnabled = true;
  bool _autoModeEnabled = true;
  int _refreshInterval = 5;
  String _selectedTheme = 'system';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _esp32UrlController.text = prefs.getString('esp32_url') ?? 'http://192.168.1.100';
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
      _autoModeEnabled = prefs.getBool('auto_mode') ?? true;
      _refreshInterval = prefs.getInt('refresh_interval') ?? 5;
      _selectedTheme = prefs.getString('theme_mode') ?? 'system';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('esp32_url', _esp32UrlController.text);
    await prefs.setBool('notifications', _notificationsEnabled);
    await prefs.setBool('auto_mode', _autoModeEnabled);
    await prefs.setInt('refresh_interval', _refreshInterval);
    await prefs.setString('theme_mode', _selectedTheme);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings saved successfully')),
      );
    }
  }

  @override
  void dispose() {
    _esp32UrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Hardware Connection'),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _esp32UrlController,
            label: 'ESP32 IP Address',
            hint: 'http://192.168.1.100',
            icon: Icons.router,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('App Preferences'),
          const SizedBox(height: 12),
          _buildSwitchTile(
            title: 'Enable Notifications',
            subtitle: 'Receive alerts for critical moisture levels',
            value: _notificationsEnabled,
            icon: Icons.notifications,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
            },
          ),
          _buildSwitchTile(
            title: 'Auto Mode by Default',
            subtitle: 'New pumps start in automatic mode',
            value: _autoModeEnabled,
            icon: Icons.auto_mode,
            onChanged: (value) {
              setState(() => _autoModeEnabled = value);
            },
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Data Refresh'),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.refresh, color: Colors.blue),
                      const SizedBox(width: 12),
                      Text(
                        'Refresh Interval: $_refreshInterval seconds',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Slider(
                    value: _refreshInterval.toDouble(),
                    min: 1,
                    max: 30,
                    divisions: 29,
                    label: '$_refreshInterval sec',
                    onChanged: (value) {
                      setState(() => _refreshInterval = value.toInt());
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Appearance'),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.palette, color: Colors.purple),
                      SizedBox(width: 12),
                      Text(
                        'Theme Mode',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'light', label: Text('Light'), icon: Icon(Icons.light_mode)),
                      ButtonSegment(value: 'dark', label: Text('Dark'), icon: Icon(Icons.dark_mode)),
                      ButtonSegment(value: 'system', label: Text('System'), icon: Icon(Icons.settings_brightness)),
                    ],
                    selected: {_selectedTheme},
                    onSelectionChanged: (Set<String> selected) {
                      setState(() {
                        _selectedTheme = selected.first;
                      });
                      // Apply theme immediately
                      final themeMode = _selectedTheme == 'light'
                          ? ThemeMode.light
                          : _selectedTheme == 'dark'
                              ? ThemeMode.dark
                              : ThemeMode.system;
                      widget.onThemeChanged?.call(themeMode);
                      _saveSettings();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('About'),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.green),
              title: Text('GreenGrid Hill'),
              subtitle: Text('Version 1.0.0\nAutonomous Hillside Irrigation System'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.bug_report, color: Colors.orange),
              title: const Text('Test Connection'),
              subtitle: const Text('Verify ESP32 connectivity'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _testConnection,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: Icon(icon),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        secondary: Icon(icon, color: Colors.blue),
      ),
    );
  }

  Future<void> _testConnection() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Testing connection...'),
          ],
        ),
      ),
    );

    // Simulate connection test
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Connection Test'),
          content: const Text('ESP32 connection successful!\nLatency: 45ms'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
