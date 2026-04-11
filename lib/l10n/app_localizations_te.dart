// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get dashboard => 'డాష్‌బోర్డ్';

  @override
  String get analytics => 'విశ్లేషణలు';

  @override
  String get settings => 'సెట్టింగులు';

  @override
  String get profile => 'ప్రొఫైల్';

  @override
  String get soilMoistureSensors => 'నేల తేమ సెన్సార్లు';

  @override
  String get valveControls => 'వాల్వ్ నియంత్రణలు';

  @override
  String get auto => 'ఆటో';

  @override
  String get manual => 'మాన్యువల్';

  @override
  String get statusAutomatic => 'స్థితి: ఆటోమేటిక్';

  @override
  String get statusManualOn => 'స్థితి: మాన్యువల్ (ఆన్)';

  @override
  String get statusSystemOff => 'స్థితి: సిస్టమ్ ఆఫ్';

  @override
  String get lastSync => 'చివరి సమకాలీకరణ';

  @override
  String get noSensorsFound =>
      'డేటా ప్రారంభించబడలేదు లేదా సెన్సార్లు కనుగొనబడలేదు.';

  @override
  String get noValvesAvailable => 'వాల్వ్‌లు అందుబాటులో లేవు.';

  @override
  String get valveActivated => 'వాల్వ్ సక్రియం చేయబడింది';

  @override
  String get valveDeactivated => 'వాల్వ్ నిష్క్రియం చేయబడింది';

  @override
  String get welcomeBack => 'స్వాగతం';

  @override
  String get signInToContinue => 'కొనసాగించడానికి సైన్ ఇన్ చేయండి';

  @override
  String get email => 'ఇమెయిల్';

  @override
  String get password => 'పాస్‌వర్డ్';

  @override
  String get rememberMe => 'నన్ను గుర్తుంచుకో';

  @override
  String get forgotPassword => 'పాస్‌వర్డ్ మర్చిపోయారా?';

  @override
  String get signIn => 'సైన్ ఇన్';

  @override
  String get dontHaveAccount => 'ఖాతా లేదా?';

  @override
  String get signUp => 'సైన్ అప్';

  @override
  String get waterUsageAnalytics => 'నీటి వినియోగ విశ్లేషణలు';

  @override
  String get today => 'నేడు';

  @override
  String get week => 'వారం';

  @override
  String get month => 'నెల';

  @override
  String get year => 'సంవత్సరం';

  @override
  String get waterUsed => 'వినియోగించిన నీరు';

  @override
  String get waterSaved => 'పొదుపు చేసిన నీరు';

  @override
  String get efficiency => 'సామర్థ్యం';

  @override
  String get usageTrend => 'వినియోగ ధోరణి';

  @override
  String get realTimeFlowMonitoring => 'నిజ-సమయ ప్రవాహ పర్యవేక్షణ';

  @override
  String get usageAnalysis => 'వినియోగ విశ్లేషణ';

  @override
  String get waterConservation => 'నీటి సంరక్షణ';

  @override
  String get irrigationActivity => 'నీటి పారుదల కార్యకలాపాలు';

  @override
  String get hardwareConnection => 'హార్డ్‌వేర్ కనెక్షన్';

  @override
  String get esp32IpAddress => 'ESP32 ఐపి చిరునామా';

  @override
  String get appPreferences => 'యాప్ ప్రాధాన్యతలు';

  @override
  String get enableNotifications => 'నోటిఫికేషన్‌లను ప్రారంభించండి';

  @override
  String get autoModeByDefault => 'డిఫాల్ట్‌గా ఆటో మోడ్';

  @override
  String get dataRefresh => 'డేటా రిఫ్రెష్';

  @override
  String get refreshInterval => 'రిఫ్రెష్ విరామం';

  @override
  String get appearance => 'రూపం';

  @override
  String get themeMode => 'థీమ్ మోడ్';

  @override
  String get light => 'లైట్';

  @override
  String get dark => 'డార్క్';

  @override
  String get system => 'సిస్టమ్';

  @override
  String get language => 'భాష';

  @override
  String get about => 'గురించి';

  @override
  String get version => 'వెర్షన్';

  @override
  String get testConnection => 'కనెక్షన్ పరీక్షించండి';

  @override
  String get save => 'సేవ్ చేయి';

  @override
  String get settingsSaved => 'సెట్టింగ్‌లు విజయవంతంగా సేవ్ చేయబడ్డాయి';

  @override
  String get statusSafe => 'సురక్షితం';

  @override
  String get statusWarning => 'హెచ్చరిక';

  @override
  String get statusCritical => 'ప్రమాదకరం';

  @override
  String get autoMode => 'ఆటో';

  @override
  String get manualMode => 'మాన్యువల్';

  @override
  String setMode(String zone, String mode) {
    return '$zone $mode మోడ్‌లోకి మార్చబడింది';
  }
}
