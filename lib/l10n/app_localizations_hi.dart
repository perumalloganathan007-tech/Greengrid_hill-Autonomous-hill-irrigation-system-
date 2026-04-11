// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get dashboard => 'डैशबोर्ड';

  @override
  String get analytics => 'विश्लेषण';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get soilMoistureSensors => 'मिट्टी की नमी सेंसर';

  @override
  String get valveControls => 'वाल्व नियंत्रण';

  @override
  String get auto => 'ऑटो';

  @override
  String get manual => 'मैनुअल';

  @override
  String get statusAutomatic => 'स्थिति: स्वचालित';

  @override
  String get statusManualOn => 'स्थिति: मैनुअल (चालू)';

  @override
  String get statusSystemOff => 'स्थिति: सिस्टम बंद';

  @override
  String get lastSync => 'अंतिम सिंक';

  @override
  String get noSensorsFound =>
      'डेटा प्रारंभ नहीं किया गया है या कोई सेंसर नहीं मिला।';

  @override
  String get noValvesAvailable => 'कोई वाल्व उपलब्ध नहीं है।';

  @override
  String get valveActivated => 'वाल्व सक्रिय';

  @override
  String get valveDeactivated => 'वाल्व निष्क्रिय';

  @override
  String get welcomeBack => 'वापसी पर स्वागत है';

  @override
  String get signInToContinue => 'जारी रखने के लिए साइन इन करें';

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get rememberMe => 'मुझे याद रखें';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get signIn => 'साइन इन करें';

  @override
  String get dontHaveAccount => 'खाता नहीं है?';

  @override
  String get signUp => 'साइन अप करें';

  @override
  String get waterUsageAnalytics => 'पानी के उपयोग का विश्लेषण';

  @override
  String get today => 'आज';

  @override
  String get week => 'सप्ताह';

  @override
  String get month => 'महीना';

  @override
  String get year => 'वर्ष';

  @override
  String get waterUsed => 'पानी का उपयोग';

  @override
  String get waterSaved => 'पानी की बचत';

  @override
  String get efficiency => 'क्षमता';

  @override
  String get usageTrend => 'उपयोग की प्रवृत्ति';

  @override
  String get realTimeFlowMonitoring => 'रीयल-टाइम प्रवाह निगरानी';

  @override
  String get usageAnalysis => 'उपयोग विश्लेषण';

  @override
  String get waterConservation => 'जल संरक्षण';

  @override
  String get irrigationActivity => 'सिंचाई गतिविधि';

  @override
  String get hardwareConnection => 'हार्डवेयर कनेक्शन';

  @override
  String get esp32IpAddress => 'ESP32 आईपी पता';

  @override
  String get appPreferences => 'ऐप प्राथमिकताएं';

  @override
  String get enableNotifications => 'सूचनाएं सक्षम करें';

  @override
  String get autoModeByDefault => 'डिफ़ॉल्ट रूप से ऑटो मोड';

  @override
  String get dataRefresh => 'डेटा रिफ्रेश';

  @override
  String get refreshInterval => 'रिफ्रेश अंतराल';

  @override
  String get appearance => 'दिखावट';

  @override
  String get themeMode => 'थीम मोड';

  @override
  String get light => 'लाइट';

  @override
  String get dark => 'डार्क';

  @override
  String get system => 'सिस्टम';

  @override
  String get language => 'भाषा';

  @override
  String get about => 'के बारे में';

  @override
  String get version => 'वर्जन';

  @override
  String get testConnection => 'कनेक्शन जांचें';

  @override
  String get save => 'सहेजें';

  @override
  String get settingsSaved => 'सेटिंग्स सफलतापूर्वक सहेजी गईं';

  @override
  String get statusSafe => 'सुरक्षित';

  @override
  String get statusWarning => 'चेतावनी';

  @override
  String get statusCritical => 'गंभीर';

  @override
  String get autoMode => 'ऑटो';

  @override
  String get manualMode => 'मैनुअल';

  @override
  String setMode(String zone, String mode) {
    return '$zone को $mode मोड पर सेट किया गया';
  }
}
