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

  @override
  String get systemEnvironment => 'सिस्टम पर्यावरण';

  @override
  String get temperature => 'तापमान';

  @override
  String get humidity => 'नमी';

  @override
  String get climateAnalysis => 'जलवायु विश्लेषण';

  @override
  String get enableNotificationsDesc =>
      'गंभीर नमी स्तरों के लिए अलर्ट प्राप्त करें';

  @override
  String get autoModeByDefaultDesc => 'नए वाल्व स्वचालित मोड में शुरू होते हैं';

  @override
  String get seconds => 'सेकंड';

  @override
  String get sec => 'सेक';

  @override
  String get appDescription => 'स्वायत्त पहाड़ी सिंचाई प्रणाली';

  @override
  String get testConnectionDesc => 'ESP32 कनेक्टिविटी सत्यापित करें';

  @override
  String get testingConnection => 'कनेक्शन की जाँच की जा रही है...';

  @override
  String get connectionTest => 'कनेक्शन परीक्षण';

  @override
  String get connectionSuccessful => 'ESP32 कनेक्शन सफल!\nलेटेंसी: 45ms';

  @override
  String get notProvided => 'प्रदान नहीं किया गया';

  @override
  String get notAvailable => 'उपलब्ध नहीं';

  @override
  String get roleUser => 'उपयोगकर्ता';

  @override
  String get unknownId => 'अज्ञात आईडी';

  @override
  String get accountInformation => 'खाता जानकारी';

  @override
  String get role => 'भूमिका';

  @override
  String get memberSince => 'सदस्यता तिथि';

  @override
  String get userId => 'उपयोगकर्ता आईडी';

  @override
  String get userIdCopied => 'उपयोगकर्ता आईडी क्लिपबोर्ड पर कॉपी की गई';

  @override
  String get mySupportTickets => 'मेरे सपोर्ट टिकट';

  @override
  String get mySupportTicketsDesc => 'फीडबैक या बग रिपोर्ट देखें और बनाएं';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get terraceZone => 'छत क्षेत्र';

  @override
  String get waterFlowRate => 'जल प्रवाह दर';

  @override
  String get pump => 'पंप';

  @override
  String get litersPerMinute => 'ली/मिनट';

  @override
  String get statusFlowing => 'बह रहा है';

  @override
  String get statusPumpOnNoFlow => 'पंप चालू / कोई प्रवाह नहीं';

  @override
  String get statusStandby => 'स्टैंडबाय';

  @override
  String get editName => 'नाम संपादित करें';

  @override
  String get enterNewName => 'नया नाम दर्ज करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get nameUpdatedSuccessfully => 'नाम सफलतापूर्वक अपडेट किया गया';

  @override
  String get nameCannotBeEmpty => 'नाम खाली नहीं हो सकता';

  @override
  String get createAccount => 'खाता बनाएं';

  @override
  String get accountCreated => 'खाता सफलतापूर्वक बनाया गया!';

  @override
  String get joinGreenGrid => 'GreenGrid Hill से जुड़ें';

  @override
  String get createAccountDesc => 'शुरू करने के लिए अपना खाता बनाएं';

  @override
  String get displayName => 'प्रदर्शित नाम';

  @override
  String get enterDisplayName => 'अपना नाम दर्ज करें';

  @override
  String get confirmPassword => 'पासवर्ड की पुष्टि करें';

  @override
  String get reEnterPassword => 'अपना पासवर्ड दोबारा दर्ज करें';

  @override
  String get alreadyHaveAccount => 'पहले से ही एक खाता है?';

  @override
  String get resetPassword => 'पासवर्ड रीसेट करें';

  @override
  String get passwordResetSent =>
      'पासवर्ड रीसेट ईमेल भेज दिया गया है! अपना इनबॉक्स जांचें।';

  @override
  String get enterEmailToReset =>
      'रीसेट निर्देश प्राप्त करने के लिए अपना ईमेल दर्ज करें';

  @override
  String get enterRegisteredEmail => 'अपना पंजीकृत ईमेल दर्ज करें';

  @override
  String get sendResetLink => 'रीसेट लिंक भेजें';

  @override
  String get rememberPassword => 'अपना पासवर्ड याद है?';

  @override
  String get appTagline => 'स्वायत्त पहाड़ी सिंचाई';

  @override
  String get enterEmail => 'अपना ईमेल दर्ज करें';

  @override
  String get enterPassword => 'अपना पासवर्ड दर्ज करें';

  @override
  String increasing(String value) {
    return 'बढ़ रहा है +$value ली/दिन';
  }

  @override
  String decreasing(String value) {
    return 'घट रहा है $value ली/दिन';
  }

  @override
  String get stable => 'स्थिर';

  @override
  String get avg => 'औसत';

  @override
  String get range => 'सीमा';

  @override
  String get liters => 'लीटर';

  @override
  String get hourOfDay => 'दिन का घंटा (24घं)';

  @override
  String get saved => 'बचाया गया';

  @override
  String get flowLevel => 'प्रवाह स्तर';

  @override
  String get monthlyTotal => 'मासिक कुल';

  @override
  String get dailyUsage => 'दैनिक उपयोग';

  @override
  String get activations => 'सक्रियण';

  @override
  String get waitingForSensor => 'सेंसर का इंतज़ार किया जा रहा है...';

  @override
  String get confirmLogout => 'लॉग आउट की पुष्टि करें';

  @override
  String get logoutConfirmationDesc =>
      'GreenGrid आपकी देखभाल के साथ सबसे अच्छा काम करता है। क्या आप वाकई सिस्टम छोड़ना चाहते हैं?';

  @override
  String get newTicket => 'नया टिकट';

  @override
  String get submitFeedback => 'प्रतिक्रिया / टिकट जमा करें';

  @override
  String get howCanWeHelp => 'हम आपकी क्या मदद कर सकते हैं?';

  @override
  String get issueType => 'समस्या का प्रकार';

  @override
  String get description => 'विवरण';

  @override
  String get submitTicket => 'टिकट जमा करें';

  @override
  String get ticketSubmitted => 'सहायता टिकट सफलतापूर्वक जमा किया गया!';

  @override
  String get enterDescription => 'कृपया विवरण दर्ज करें';

  @override
  String get descriptionTooShort => 'विवरण बहुत छोटा है';

  @override
  String get bug => 'बग';

  @override
  String get suggestion => 'सुझाव';

  @override
  String get other => 'अन्य';

  @override
  String get open => 'खुला';

  @override
  String get processing => 'प्रक्रिया में';

  @override
  String get resolved => 'समाधान';

  @override
  String get closed => 'बंद';

  @override
  String get noSupportTickets => 'आपके पास कोई सहायता टिकट नहीं है।';

  @override
  String get noSupportTicketsDesc =>
      'प्रतिक्रिया देने या बग की रिपोर्ट करने के लिए + बटन दबाएं।';

  @override
  String get adminReply => 'एडमिन का जवाब';

  @override
  String get manageSupportTicket => 'सहायता टिकट प्रबंधित करें';

  @override
  String get user => 'उपयोगकर्ता';

  @override
  String get markAsProcessing => 'प्रक्रिया में मार्क करें';

  @override
  String get resolveAndSendReply => 'समाधान करें और जवाब भेजें';

  @override
  String get replyCannotBeEmpty => 'जवाब खाली नहीं हो सकता';

  @override
  String get all => 'सब';

  @override
  String get active => 'सक्रिय';

  @override
  String noTicketsFound(String status) {
    return 'कोई $status टिकट नहीं मिला।';
  }

  @override
  String get report => 'रिपोर्ट';

  @override
  String get error => 'त्रुटि';

  @override
  String get adminDashboard => 'एडमिन डैशबोर्ड';

  @override
  String get users => 'उपयोगकर्ता';

  @override
  String get tickets => 'टिकट';

  @override
  String get searchByUsernameOrId => 'उपयोगकर्ता नाम या आईडी द्वारा खोजें...';

  @override
  String get errorLoadingUsers => 'उपयोगकर्ताओं को लोड करने में त्रुटि';

  @override
  String get noRegisteredUsers => 'कोई पंजीकृत उपयोगकर्ता नहीं मिला।';

  @override
  String noUsersMatching(String query) {
    return '\"$query\" से मेल खाने वाला कोई उपयोगकर्ता नहीं मिला';
  }

  @override
  String get adminLabel => 'एडमिन';

  @override
  String get userLabel => 'उपयोगकर्ता';

  @override
  String get online => 'ऑनलाइन';

  @override
  String get offline => 'ऑफलाइन';

  @override
  String get telemetry => 'टेलीमेट्री';

  @override
  String get history => 'इतिहास';

  @override
  String get loginFrequency7Days => 'लॉगिन आवृत्ति (7 दिन)';

  @override
  String get noLoginActivityFound => 'कोई लॉगिन गतिविधि नहीं मिली।';

  @override
  String get refresh => 'रिफ्रेश करें';

  @override
  String get errorLoadingLogs => 'लॉग लोड करने में त्रुटि';
}
