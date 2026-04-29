import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('ml'),
    Locale('ta'),
    Locale('te'),
  ];

  /// Navigation label for dashboard
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @soilMoistureSensors.
  ///
  /// In en, this message translates to:
  /// **'Soil Moisture Sensors'**
  String get soilMoistureSensors;

  /// No description provided for @valveControls.
  ///
  /// In en, this message translates to:
  /// **'Valve Controls'**
  String get valveControls;

  /// No description provided for @auto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get auto;

  /// No description provided for @manual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get manual;

  /// No description provided for @statusAutomatic.
  ///
  /// In en, this message translates to:
  /// **'STATUS: AUTOMATIC'**
  String get statusAutomatic;

  /// No description provided for @statusManualOn.
  ///
  /// In en, this message translates to:
  /// **'STATUS: MANUAL (ON)'**
  String get statusManualOn;

  /// No description provided for @statusSystemOff.
  ///
  /// In en, this message translates to:
  /// **'STATUS: SYSTEM OFF'**
  String get statusSystemOff;

  /// No description provided for @lastSync.
  ///
  /// In en, this message translates to:
  /// **'LAST SYNC'**
  String get lastSync;

  /// No description provided for @noSensorsFound.
  ///
  /// In en, this message translates to:
  /// **'Data is not initialized or no sensors found.'**
  String get noSensorsFound;

  /// No description provided for @noValvesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No valves available.'**
  String get noValvesAvailable;

  /// No description provided for @valveActivated.
  ///
  /// In en, this message translates to:
  /// **'Valve activated'**
  String get valveActivated;

  /// No description provided for @valveDeactivated.
  ///
  /// In en, this message translates to:
  /// **'Valve deactivated'**
  String get valveDeactivated;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @waterUsageAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Water Usage Analytics'**
  String get waterUsageAnalytics;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @waterUsed.
  ///
  /// In en, this message translates to:
  /// **'Water Used'**
  String get waterUsed;

  /// No description provided for @waterSaved.
  ///
  /// In en, this message translates to:
  /// **'Water Saved'**
  String get waterSaved;

  /// No description provided for @efficiency.
  ///
  /// In en, this message translates to:
  /// **'Efficiency'**
  String get efficiency;

  /// No description provided for @usageTrend.
  ///
  /// In en, this message translates to:
  /// **'Usage Trend'**
  String get usageTrend;

  /// No description provided for @realTimeFlowMonitoring.
  ///
  /// In en, this message translates to:
  /// **'Real-time Flow Monitoring'**
  String get realTimeFlowMonitoring;

  /// No description provided for @usageAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Usage Analysis'**
  String get usageAnalysis;

  /// No description provided for @waterConservation.
  ///
  /// In en, this message translates to:
  /// **'Water Conservation'**
  String get waterConservation;

  /// No description provided for @irrigationActivity.
  ///
  /// In en, this message translates to:
  /// **'Irrigation Activity'**
  String get irrigationActivity;

  /// No description provided for @hardwareConnection.
  ///
  /// In en, this message translates to:
  /// **'Hardware Connection'**
  String get hardwareConnection;

  /// No description provided for @esp32IpAddress.
  ///
  /// In en, this message translates to:
  /// **'ESP32 IP Address'**
  String get esp32IpAddress;

  /// No description provided for @appPreferences.
  ///
  /// In en, this message translates to:
  /// **'App Preferences'**
  String get appPreferences;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @autoModeByDefault.
  ///
  /// In en, this message translates to:
  /// **'Auto Mode by Default'**
  String get autoModeByDefault;

  /// No description provided for @dataRefresh.
  ///
  /// In en, this message translates to:
  /// **'Data Refresh'**
  String get dataRefresh;

  /// No description provided for @refreshInterval.
  ///
  /// In en, this message translates to:
  /// **'Refresh Interval'**
  String get refreshInterval;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @testConnection.
  ///
  /// In en, this message translates to:
  /// **'Test Connection'**
  String get testConnection;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully'**
  String get settingsSaved;

  /// No description provided for @statusSafe.
  ///
  /// In en, this message translates to:
  /// **'SAFE'**
  String get statusSafe;

  /// No description provided for @statusWarning.
  ///
  /// In en, this message translates to:
  /// **'WARNING'**
  String get statusWarning;

  /// No description provided for @statusCritical.
  ///
  /// In en, this message translates to:
  /// **'CRITICAL'**
  String get statusCritical;

  /// No description provided for @autoMode.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get autoMode;

  /// No description provided for @manualMode.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get manualMode;

  /// No description provided for @setMode.
  ///
  /// In en, this message translates to:
  /// **'{zone} set to {mode} mode'**
  String setMode(String zone, String mode);

  /// No description provided for @systemEnvironment.
  ///
  /// In en, this message translates to:
  /// **'System Environment'**
  String get systemEnvironment;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @climateAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Climate Analysis'**
  String get climateAnalysis;

  /// No description provided for @enableNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive alerts for critical moisture levels'**
  String get enableNotificationsDesc;

  /// No description provided for @autoModeByDefaultDesc.
  ///
  /// In en, this message translates to:
  /// **'New valves start in automatic mode'**
  String get autoModeByDefaultDesc;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @sec.
  ///
  /// In en, this message translates to:
  /// **'sec'**
  String get sec;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'Autonomous Hillside Irrigation System'**
  String get appDescription;

  /// No description provided for @testConnectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Verify ESP32 connectivity'**
  String get testConnectionDesc;

  /// No description provided for @testingConnection.
  ///
  /// In en, this message translates to:
  /// **'Testing connection...'**
  String get testingConnection;

  /// No description provided for @connectionTest.
  ///
  /// In en, this message translates to:
  /// **'Connection Test'**
  String get connectionTest;

  /// No description provided for @connectionSuccessful.
  ///
  /// In en, this message translates to:
  /// **'ESP32 connection successful!\nLatency: 45ms'**
  String get connectionSuccessful;

  /// No description provided for @notProvided.
  ///
  /// In en, this message translates to:
  /// **'Not Provided'**
  String get notProvided;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @roleUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get roleUser;

  /// No description provided for @unknownId.
  ///
  /// In en, this message translates to:
  /// **'Unknown ID'**
  String get unknownId;

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get memberSince;

  /// No description provided for @userId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userId;

  /// No description provided for @userIdCopied.
  ///
  /// In en, this message translates to:
  /// **'User ID copied to clipboard'**
  String get userIdCopied;

  /// No description provided for @mySupportTickets.
  ///
  /// In en, this message translates to:
  /// **'My Support Tickets'**
  String get mySupportTickets;

  /// No description provided for @mySupportTicketsDesc.
  ///
  /// In en, this message translates to:
  /// **'View and create feedback or bug reports'**
  String get mySupportTicketsDesc;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @terraceZone.
  ///
  /// In en, this message translates to:
  /// **'Terrace Zone'**
  String get terraceZone;

  /// No description provided for @waterFlowRate.
  ///
  /// In en, this message translates to:
  /// **'Water Flow Rate'**
  String get waterFlowRate;

  /// No description provided for @pump.
  ///
  /// In en, this message translates to:
  /// **'Pump'**
  String get pump;

  /// No description provided for @litersPerMinute.
  ///
  /// In en, this message translates to:
  /// **'L/min'**
  String get litersPerMinute;

  /// No description provided for @statusFlowing.
  ///
  /// In en, this message translates to:
  /// **'Flowing'**
  String get statusFlowing;

  /// No description provided for @statusPumpOnNoFlow.
  ///
  /// In en, this message translates to:
  /// **'Pump On / No Flow'**
  String get statusPumpOnNoFlow;

  /// No description provided for @statusStandby.
  ///
  /// In en, this message translates to:
  /// **'Standby'**
  String get statusStandby;

  /// No description provided for @editName.
  ///
  /// In en, this message translates to:
  /// **'Edit Name'**
  String get editName;

  /// No description provided for @enterNewName.
  ///
  /// In en, this message translates to:
  /// **'Enter new name'**
  String get enterNewName;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @nameUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Name updated successfully'**
  String get nameUpdatedSuccessfully;

  /// No description provided for @nameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get nameCannotBeEmpty;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreated;

  /// No description provided for @joinGreenGrid.
  ///
  /// In en, this message translates to:
  /// **'Join GreenGrid Hill'**
  String get joinGreenGrid;

  /// No description provided for @createAccountDesc.
  ///
  /// In en, this message translates to:
  /// **'Create your account to get started'**
  String get createAccountDesc;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// No description provided for @enterDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterDisplayName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @reEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get reEnterPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent! Check your inbox.'**
  String get passwordResetSent;

  /// No description provided for @enterEmailToReset.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive reset instructions'**
  String get enterEmailToReset;

  /// No description provided for @enterRegisteredEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email'**
  String get enterRegisteredEmail;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @rememberPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get rememberPassword;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Autonomous Hillside Irrigation'**
  String get appTagline;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @increasing.
  ///
  /// In en, this message translates to:
  /// **'Increasing +{value} L/day'**
  String increasing(String value);

  /// No description provided for @decreasing.
  ///
  /// In en, this message translates to:
  /// **'Decreasing {value} L/day'**
  String decreasing(String value);

  /// No description provided for @stable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get stable;

  /// No description provided for @avg.
  ///
  /// In en, this message translates to:
  /// **'Avg'**
  String get avg;

  /// No description provided for @range.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get range;

  /// No description provided for @liters.
  ///
  /// In en, this message translates to:
  /// **'Liters'**
  String get liters;

  /// No description provided for @hourOfDay.
  ///
  /// In en, this message translates to:
  /// **'Hour of Day (24h)'**
  String get hourOfDay;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @flowLevel.
  ///
  /// In en, this message translates to:
  /// **'Flow Level'**
  String get flowLevel;

  /// No description provided for @monthlyTotal.
  ///
  /// In en, this message translates to:
  /// **'Monthly Total'**
  String get monthlyTotal;

  /// No description provided for @dailyUsage.
  ///
  /// In en, this message translates to:
  /// **'Daily Usage'**
  String get dailyUsage;

  /// No description provided for @activations.
  ///
  /// In en, this message translates to:
  /// **'Activations'**
  String get activations;

  /// No description provided for @waitingForSensor.
  ///
  /// In en, this message translates to:
  /// **'Waiting for sensor...'**
  String get waitingForSensor;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @logoutConfirmationDesc.
  ///
  /// In en, this message translates to:
  /// **'The GreenGrid works best with your care. Are you sure you want to leave the system?'**
  String get logoutConfirmationDesc;

  /// No description provided for @newTicket.
  ///
  /// In en, this message translates to:
  /// **'New Ticket'**
  String get newTicket;

  /// No description provided for @submitFeedback.
  ///
  /// In en, this message translates to:
  /// **'Submit Feedback / Ticket'**
  String get submitFeedback;

  /// No description provided for @howCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How can we help?'**
  String get howCanWeHelp;

  /// No description provided for @issueType.
  ///
  /// In en, this message translates to:
  /// **'Issue Type'**
  String get issueType;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @submitTicket.
  ///
  /// In en, this message translates to:
  /// **'SUBMIT TICKET'**
  String get submitTicket;

  /// No description provided for @ticketSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Support ticket submitted successfully!'**
  String get ticketSubmitted;

  /// No description provided for @enterDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get enterDescription;

  /// No description provided for @descriptionTooShort.
  ///
  /// In en, this message translates to:
  /// **'Description is too short'**
  String get descriptionTooShort;

  /// No description provided for @bug.
  ///
  /// In en, this message translates to:
  /// **'Bug'**
  String get bug;

  /// No description provided for @suggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion'**
  String get suggestion;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolved;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @noSupportTickets.
  ///
  /// In en, this message translates to:
  /// **'You have no support tickets.'**
  String get noSupportTickets;

  /// No description provided for @noSupportTicketsDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to submit feedback or report a bug.'**
  String get noSupportTicketsDesc;

  /// No description provided for @adminReply.
  ///
  /// In en, this message translates to:
  /// **'Admin Reply'**
  String get adminReply;

  /// No description provided for @manageSupportTicket.
  ///
  /// In en, this message translates to:
  /// **'Manage Support Ticket'**
  String get manageSupportTicket;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @markAsProcessing.
  ///
  /// In en, this message translates to:
  /// **'Mark as Processing'**
  String get markAsProcessing;

  /// No description provided for @resolveAndSendReply.
  ///
  /// In en, this message translates to:
  /// **'Resolve & Send Reply'**
  String get resolveAndSendReply;

  /// No description provided for @replyCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Reply cannot be empty'**
  String get replyCannotBeEmpty;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @noTicketsFound.
  ///
  /// In en, this message translates to:
  /// **'No {status} tickets found.'**
  String noTicketsFound(String status);

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @adminDashboard.
  ///
  /// In en, this message translates to:
  /// **'ADMIN DASHBOARD'**
  String get adminDashboard;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @tickets.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get tickets;

  /// No description provided for @searchByUsernameOrId.
  ///
  /// In en, this message translates to:
  /// **'Search by username or ID...'**
  String get searchByUsernameOrId;

  /// No description provided for @errorLoadingUsers.
  ///
  /// In en, this message translates to:
  /// **'Error loading users'**
  String get errorLoadingUsers;

  /// No description provided for @noRegisteredUsers.
  ///
  /// In en, this message translates to:
  /// **'No registered users found.'**
  String get noRegisteredUsers;

  /// No description provided for @noUsersMatching.
  ///
  /// In en, this message translates to:
  /// **'No users matching \"{query}\"'**
  String noUsersMatching(String query);

  /// No description provided for @adminLabel.
  ///
  /// In en, this message translates to:
  /// **'ADMIN'**
  String get adminLabel;

  /// No description provided for @userLabel.
  ///
  /// In en, this message translates to:
  /// **'USER'**
  String get userLabel;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @telemetry.
  ///
  /// In en, this message translates to:
  /// **'Telemetry'**
  String get telemetry;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @loginFrequency7Days.
  ///
  /// In en, this message translates to:
  /// **'LOGIN FREQUENCY (7 DAYS)'**
  String get loginFrequency7Days;

  /// No description provided for @noLoginActivityFound.
  ///
  /// In en, this message translates to:
  /// **'No login activity found.'**
  String get noLoginActivityFound;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @errorLoadingLogs.
  ///
  /// In en, this message translates to:
  /// **'Error loading logs'**
  String get errorLoadingLogs;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'ml', 'ta', 'te'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'ml':
      return AppLocalizationsMl();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
