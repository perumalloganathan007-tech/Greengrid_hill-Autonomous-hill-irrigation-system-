// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get dashboard => 'டாஷ்போர்டு';

  @override
  String get analytics => 'பகுப்பாய்வு';

  @override
  String get settings => 'அமைப்புகள்';

  @override
  String get profile => 'சுயவிவரம்';

  @override
  String get soilMoistureSensors => 'மண் ஈரப்பதம் உணரிகள்';

  @override
  String get valveControls => 'வால்வு கட்டுப்பாடுகள்';

  @override
  String get auto => 'ஆட்டோ';

  @override
  String get manual => 'மேனுவல்';

  @override
  String get statusAutomatic => 'நிலை: தானியங்கி';

  @override
  String get statusManualOn => 'நிலை: கையேடு (ஆன்)';

  @override
  String get statusSystemOff => 'நிலை: சிஸ்டம் ஆஃப்';

  @override
  String get lastSync => 'கடைசி ஒத்திசைவு';

  @override
  String get noSensorsFound =>
      'தரவு துவக்கப்படவில்லை அல்லது சென்சார்கள் இல்லை.';

  @override
  String get noValvesAvailable => 'வால்வுகள் இல்லை.';

  @override
  String get valveActivated => 'வால்வு செயல்படுத்தப்பட்டது';

  @override
  String get valveDeactivated => 'வால்வு செயலிழக்கப்பட்டது';

  @override
  String get welcomeBack => 'மீண்டும் வருக';

  @override
  String get signInToContinue => 'தொடர உள்நுழையவும்';

  @override
  String get email => 'மின்னஞ்சல்';

  @override
  String get password => 'கடவுச்சொல்';

  @override
  String get rememberMe => 'என்னை நினைவில் கொள்க';

  @override
  String get forgotPassword => 'கடவுச்சொல்லை மறந்துவிட்டீர்களா?';

  @override
  String get signIn => 'உள்நுழை';

  @override
  String get dontHaveAccount => 'கணக்கு இல்லையா?';

  @override
  String get signUp => 'பதிவு செய்';

  @override
  String get waterUsageAnalytics => 'நீர் பயன்பாடு பகுப்பாய்வு';

  @override
  String get today => 'இன்று';

  @override
  String get week => 'வாரம்';

  @override
  String get month => 'மாதம்';

  @override
  String get year => 'ஆண்டு';

  @override
  String get waterUsed => 'பயன்படுத்தப்பட்ட நீர்';

  @override
  String get waterSaved => 'சேமிக்கப்பட்ட நீர்';

  @override
  String get efficiency => 'திறன்';

  @override
  String get usageTrend => 'பயன்பாட்டு போக்கு';

  @override
  String get realTimeFlowMonitoring => 'நிகழ்நேர ஓட்டம் கண்காணிப்பு';

  @override
  String get usageAnalysis => 'பயன்பாட்டு பகுப்பாய்வு';

  @override
  String get waterConservation => 'நீர் பாதுகாப்பு';

  @override
  String get irrigationActivity => 'பாசன நடவடிக்கை';

  @override
  String get hardwareConnection => 'வன்பொருள் இணைப்பு';

  @override
  String get esp32IpAddress => 'ESP32 ஐபி முகவரி';

  @override
  String get appPreferences => 'பயன்பாட்டு விருப்பங்கள்';

  @override
  String get enableNotifications => 'அறிவிப்புகளை இயக்கு';

  @override
  String get autoModeByDefault => 'இயல்பாக ஆட்டோ பயன்முறை';

  @override
  String get dataRefresh => 'தரவு புதுப்பிப்பு';

  @override
  String get refreshInterval => 'புதுப்பிப்பு இடைவெளி';

  @override
  String get appearance => 'தோற்றம்';

  @override
  String get themeMode => 'தீம் பயன்முறை';

  @override
  String get light => 'லைட்';

  @override
  String get dark => 'டார்க்';

  @override
  String get system => 'சிஸ்டம்';

  @override
  String get language => 'மொழி';

  @override
  String get about => 'பற்றி';

  @override
  String get version => 'பதிப்பு';

  @override
  String get testConnection => 'சோதனை இணைப்பு';

  @override
  String get save => 'சேமி';

  @override
  String get settingsSaved => 'அமைப்புகள் வெற்றிகரமாக சேமிக்கப்பட்டன';

  @override
  String get statusSafe => 'பாதுகாப்பானது';

  @override
  String get statusWarning => 'எச்சரிக்கை';

  @override
  String get statusCritical => 'மிகவும் குறைவு';

  @override
  String get autoMode => 'ஆட்டோ';

  @override
  String get manualMode => 'மேனுவல்';

  @override
  String setMode(String zone, String mode) {
    return '$zone $mode பயன்முறைக்கு மாற்றப்பட்டது';
  }
}
