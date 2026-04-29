// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get dashboard => 'Dashboard';

  @override
  String get analytics => 'Analytics';

  @override
  String get settings => 'Settings';

  @override
  String get profile => 'Profile';

  @override
  String get soilMoistureSensors => 'Soil Moisture Sensors';

  @override
  String get valveControls => 'Valve Controls';

  @override
  String get auto => 'Auto';

  @override
  String get manual => 'Manual';

  @override
  String get statusAutomatic => 'STATUS: AUTOMATIC';

  @override
  String get statusManualOn => 'STATUS: MANUAL (ON)';

  @override
  String get statusSystemOff => 'STATUS: SYSTEM OFF';

  @override
  String get lastSync => 'LAST SYNC';

  @override
  String get noSensorsFound => 'Data is not initialized or no sensors found.';

  @override
  String get noValvesAvailable => 'No valves available.';

  @override
  String get valveActivated => 'Valve activated';

  @override
  String get valveDeactivated => 'Valve deactivated';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get signIn => 'Sign In';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get waterUsageAnalytics => 'Water Usage Analytics';

  @override
  String get today => 'Today';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get waterUsed => 'Water Used';

  @override
  String get waterSaved => 'Water Saved';

  @override
  String get efficiency => 'Efficiency';

  @override
  String get usageTrend => 'Usage Trend';

  @override
  String get realTimeFlowMonitoring => 'Real-time Flow Monitoring';

  @override
  String get usageAnalysis => 'Usage Analysis';

  @override
  String get waterConservation => 'Water Conservation';

  @override
  String get irrigationActivity => 'Irrigation Activity';

  @override
  String get hardwareConnection => 'Hardware Connection';

  @override
  String get esp32IpAddress => 'ESP32 IP Address';

  @override
  String get appPreferences => 'App Preferences';

  @override
  String get enableNotifications => 'Enable Notifications';

  @override
  String get autoModeByDefault => 'Auto Mode by Default';

  @override
  String get dataRefresh => 'Data Refresh';

  @override
  String get refreshInterval => 'Refresh Interval';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get language => 'Language';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get testConnection => 'Test Connection';

  @override
  String get save => 'Save';

  @override
  String get settingsSaved => 'Settings saved successfully';

  @override
  String get statusSafe => 'SAFE';

  @override
  String get statusWarning => 'WARNING';

  @override
  String get statusCritical => 'CRITICAL';

  @override
  String get autoMode => 'Auto';

  @override
  String get manualMode => 'Manual';

  @override
  String setMode(String zone, String mode) {
    return '$zone set to $mode mode';
  }

  @override
  String get systemEnvironment => 'System Environment';

  @override
  String get temperature => 'Temperature';

  @override
  String get humidity => 'Humidity';

  @override
  String get climateAnalysis => 'Climate Analysis';

  @override
  String get enableNotificationsDesc =>
      'Receive alerts for critical moisture levels';

  @override
  String get autoModeByDefaultDesc => 'New valves start in automatic mode';

  @override
  String get seconds => 'seconds';

  @override
  String get sec => 'sec';

  @override
  String get appDescription => 'Autonomous Hillside Irrigation System';

  @override
  String get testConnectionDesc => 'Verify ESP32 connectivity';

  @override
  String get testingConnection => 'Testing connection...';

  @override
  String get connectionTest => 'Connection Test';

  @override
  String get connectionSuccessful =>
      'ESP32 connection successful!\nLatency: 45ms';

  @override
  String get notProvided => 'Not Provided';

  @override
  String get notAvailable => 'Not Available';

  @override
  String get roleUser => 'User';

  @override
  String get unknownId => 'Unknown ID';

  @override
  String get accountInformation => 'Account Information';

  @override
  String get role => 'Role';

  @override
  String get memberSince => 'Member Since';

  @override
  String get userId => 'User ID';

  @override
  String get userIdCopied => 'User ID copied to clipboard';

  @override
  String get mySupportTickets => 'My Support Tickets';

  @override
  String get mySupportTicketsDesc => 'View and create feedback or bug reports';

  @override
  String get logout => 'Logout';

  @override
  String get terraceZone => 'Terrace Zone';

  @override
  String get waterFlowRate => 'Water Flow Rate';

  @override
  String get pump => 'Pump';

  @override
  String get litersPerMinute => 'L/min';

  @override
  String get statusFlowing => 'Flowing';

  @override
  String get statusPumpOnNoFlow => 'Pump On / No Flow';

  @override
  String get statusStandby => 'Standby';

  @override
  String get editName => 'Edit Name';

  @override
  String get enterNewName => 'Enter new name';

  @override
  String get cancel => 'Cancel';

  @override
  String get nameUpdatedSuccessfully => 'Name updated successfully';

  @override
  String get nameCannotBeEmpty => 'Name cannot be empty';

  @override
  String get createAccount => 'Create Account';

  @override
  String get accountCreated => 'Account created successfully!';

  @override
  String get joinGreenGrid => 'Join GreenGrid Hill';

  @override
  String get createAccountDesc => 'Create your account to get started';

  @override
  String get displayName => 'Display Name';

  @override
  String get enterDisplayName => 'Enter your name';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get reEnterPassword => 'Re-enter your password';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get passwordResetSent =>
      'Password reset email sent! Check your inbox.';

  @override
  String get enterEmailToReset =>
      'Enter your email to receive reset instructions';

  @override
  String get enterRegisteredEmail => 'Enter your registered email';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get rememberPassword => 'Remember your password?';

  @override
  String get appTagline => 'Autonomous Hillside Irrigation';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String increasing(String value) {
    return 'Increasing +$value L/day';
  }

  @override
  String decreasing(String value) {
    return 'Decreasing $value L/day';
  }

  @override
  String get stable => 'Stable';

  @override
  String get avg => 'Avg';

  @override
  String get range => 'Range';

  @override
  String get liters => 'Liters';

  @override
  String get hourOfDay => 'Hour of Day (24h)';

  @override
  String get saved => 'Saved';

  @override
  String get flowLevel => 'Flow Level';

  @override
  String get monthlyTotal => 'Monthly Total';

  @override
  String get dailyUsage => 'Daily Usage';

  @override
  String get activations => 'Activations';

  @override
  String get waitingForSensor => 'Waiting for sensor...';

  @override
  String get confirmLogout => 'Confirm Logout';

  @override
  String get logoutConfirmationDesc =>
      'The GreenGrid works best with your care. Are you sure you want to leave the system?';

  @override
  String get newTicket => 'New Ticket';

  @override
  String get submitFeedback => 'Submit Feedback / Ticket';

  @override
  String get howCanWeHelp => 'How can we help?';

  @override
  String get issueType => 'Issue Type';

  @override
  String get description => 'Description';

  @override
  String get submitTicket => 'SUBMIT TICKET';

  @override
  String get ticketSubmitted => 'Support ticket submitted successfully!';

  @override
  String get enterDescription => 'Please enter a description';

  @override
  String get descriptionTooShort => 'Description is too short';

  @override
  String get bug => 'Bug';

  @override
  String get suggestion => 'Suggestion';

  @override
  String get other => 'Other';

  @override
  String get open => 'Open';

  @override
  String get processing => 'Processing';

  @override
  String get resolved => 'Resolved';

  @override
  String get closed => 'Closed';

  @override
  String get noSupportTickets => 'You have no support tickets.';

  @override
  String get noSupportTicketsDesc =>
      'Tap the + button to submit feedback or report a bug.';

  @override
  String get adminReply => 'Admin Reply';

  @override
  String get manageSupportTicket => 'Manage Support Ticket';

  @override
  String get user => 'User';

  @override
  String get markAsProcessing => 'Mark as Processing';

  @override
  String get resolveAndSendReply => 'Resolve & Send Reply';

  @override
  String get replyCannotBeEmpty => 'Reply cannot be empty';

  @override
  String get all => 'All';

  @override
  String get active => 'Active';

  @override
  String noTicketsFound(String status) {
    return 'No $status tickets found.';
  }

  @override
  String get report => 'Report';

  @override
  String get error => 'Error';

  @override
  String get adminDashboard => 'ADMIN DASHBOARD';

  @override
  String get users => 'Users';

  @override
  String get tickets => 'Tickets';

  @override
  String get searchByUsernameOrId => 'Search by username or ID...';

  @override
  String get errorLoadingUsers => 'Error loading users';

  @override
  String get noRegisteredUsers => 'No registered users found.';

  @override
  String noUsersMatching(String query) {
    return 'No users matching \"$query\"';
  }

  @override
  String get adminLabel => 'ADMIN';

  @override
  String get userLabel => 'USER';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get telemetry => 'Telemetry';

  @override
  String get history => 'History';

  @override
  String get loginFrequency7Days => 'LOGIN FREQUENCY (7 DAYS)';

  @override
  String get noLoginActivityFound => 'No login activity found.';

  @override
  String get refresh => 'Refresh';

  @override
  String get errorLoadingLogs => 'Error loading logs';
}
