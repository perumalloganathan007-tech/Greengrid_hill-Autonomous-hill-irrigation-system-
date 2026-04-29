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

  @override
  String get systemEnvironment => 'சிஸ்டம் சுற்றுச்சூழல்';

  @override
  String get temperature => 'வெப்பநிலை';

  @override
  String get humidity => 'ஈரப்பதம்';

  @override
  String get climateAnalysis => 'காலநிலை பகுப்பாய்வு';

  @override
  String get enableNotificationsDesc =>
      'முக்கியமான ஈரப்பத நிலைகளுக்கான விழிப்பூட்டல்களைப் பெறுக';

  @override
  String get autoModeByDefaultDesc =>
      'புதிய வால்வுகள் தானியங்கி முறையில் தொடங்கும்';

  @override
  String get seconds => 'வினாடிகள்';

  @override
  String get sec => 'விநாடி';

  @override
  String get appDescription => 'தன்னியக்க மலைப்பாங்கான நீர்ப்பாசன அமைப்பு';

  @override
  String get testConnectionDesc => 'ESP32 இணைப்பைச் சரிபார்க்கவும்';

  @override
  String get testingConnection => 'இணைப்பைச் சோதிக்கிறது...';

  @override
  String get connectionTest => 'இணைப்பு சோதனை';

  @override
  String get connectionSuccessful =>
      'ESP32 இணைப்பு வெற்றிகரமாக உள்ளது!\nதாமதம்: 45ms';

  @override
  String get notProvided => 'வழங்கப்படவில்லை';

  @override
  String get notAvailable => 'கிடைக்கவில்லை';

  @override
  String get roleUser => 'பயனர்';

  @override
  String get unknownId => 'தெரியாத ஐடி';

  @override
  String get accountInformation => 'கணக்கு தகவல்';

  @override
  String get role => 'பங்கு';

  @override
  String get memberSince => 'உறுப்பினர் தேதி';

  @override
  String get userId => 'பயனர் ஐடி';

  @override
  String get userIdCopied => 'பயனர் ஐடி கிளிப்போர்டுக்கு நகலெடுக்கப்பட்டது';

  @override
  String get mySupportTickets => 'என் ஆதரவு டிக்கெட்டுகள்';

  @override
  String get mySupportTicketsDesc =>
      'பின்னூட்டம் அல்லது பிழை அறிக்கைகளைக் காண்க மற்றும் உருவாக்கவும்';

  @override
  String get logout => 'வெளியேறு';

  @override
  String get terraceZone => 'டெரஸ் மண்டலம்';

  @override
  String get waterFlowRate => 'நீர் ஓட்ட விகிதம்';

  @override
  String get pump => 'பம்ப்';

  @override
  String get litersPerMinute => 'லி/நிமி';

  @override
  String get statusFlowing => 'பாய்கிறது';

  @override
  String get statusPumpOnNoFlow => 'பம்ப் ஆன் / ஓட்டம் இல்லை';

  @override
  String get statusStandby => 'காத்திருப்பு';

  @override
  String get editName => 'பெயரை திருத்து';

  @override
  String get enterNewName => 'புதிய பெயரை உள்ளிடவும்';

  @override
  String get cancel => 'ரத்துசெய்';

  @override
  String get nameUpdatedSuccessfully => 'பெயர் வெற்றிகரமாக புதுப்பிக்கப்பட்டது';

  @override
  String get nameCannotBeEmpty => 'பெயர் காலியாக இருக்கக்கூடாது';

  @override
  String get createAccount => 'கணக்கை உருவாக்கு';

  @override
  String get accountCreated => 'கணக்கு வெற்றிகரமாக உருவாக்கப்பட்டது!';

  @override
  String get joinGreenGrid => 'GreenGrid Hill-இல் இணையுங்கள்';

  @override
  String get createAccountDesc => 'தொடங்குவதற்கு உங்கள் கணக்கை உருவாக்குங்கள்';

  @override
  String get displayName => 'காட்சிப் பெயர்';

  @override
  String get enterDisplayName => 'உங்கள் பெயரை உள்ளிடவும்';

  @override
  String get confirmPassword => 'கடவுச்சொல்லை உறுதிப்படுத்தவும்';

  @override
  String get reEnterPassword => 'உங்கள் கடவுச்சொல்லை மீண்டும் உள்ளிடவும்';

  @override
  String get alreadyHaveAccount => 'ஏற்கனவே கணக்கு உள்ளதா?';

  @override
  String get resetPassword => 'கடவுச்சொல்லை மீட்டமை';

  @override
  String get passwordResetSent =>
      'கடவுச்சொல் மீட்டமைப்பு மின்னஞ்சல் அனுப்பப்பட்டது! உங்கள் இன்பாக்ஸைச் சரிபார்க்கவும்.';

  @override
  String get enterEmailToReset =>
      'மீட்டமைப்பு வழிமுறைகளைப் பெற உங்கள் மின்னஞ்சலை உள்ளிடவும்';

  @override
  String get enterRegisteredEmail =>
      'உங்கள் பதிவு செய்யப்பட்ட மின்னஞ்சலை உள்ளிடவும்';

  @override
  String get sendResetLink => 'மீட்டமைப்பு இணைப்பை அனுப்பு';

  @override
  String get rememberPassword => 'உங்கள் கடவுச்சொல் நினைவிருக்கிறதா?';

  @override
  String get appTagline => 'தன்னியக்க மலைப்பாங்கான நீர்ப்பாசனம்';

  @override
  String get enterEmail => 'உங்கள் மின்னஞ்சலை உள்ளிடவும்';

  @override
  String get enterPassword => 'உங்கள் கடவுச்சொல்லை உள்ளிடவும்';

  @override
  String increasing(String value) {
    return 'அதிகரிக்கிறது +$value லி/நாள்';
  }

  @override
  String decreasing(String value) {
    return 'குறைகிறது $value லி/நாள்';
  }

  @override
  String get stable => 'நிலையானது';

  @override
  String get avg => 'சராசரி';

  @override
  String get range => 'வரம்பு';

  @override
  String get liters => 'லிட்டர்கள்';

  @override
  String get hourOfDay => 'நாள் நேரம் (24 மணி)';

  @override
  String get saved => 'சேமிக்கப்பட்டது';

  @override
  String get flowLevel => 'ஓட்ட நிலை';

  @override
  String get monthlyTotal => 'மாதாந்திர மொத்தம்';

  @override
  String get dailyUsage => 'தினசரி பயன்பாடு';

  @override
  String get activations => 'செயல்பாடுகள்';

  @override
  String get waitingForSensor => 'சென்சாருக்காக காத்திருக்கிறது...';

  @override
  String get confirmLogout => 'வெளியேறுவதை உறுதிப்படுத்தவும்';

  @override
  String get logoutConfirmationDesc =>
      'GreenGrid உங்கள் பராமரிப்பில் சிறப்பாகச் செயல்படுகிறது. நீங்கள் நிச்சயமாக வெளியேற விரும்புகிறீர்களா?';

  @override
  String get newTicket => 'புதிய டிக்கெட்';

  @override
  String get submitFeedback => 'கருத்து / டிக்கெட்டைச் சமர்ப்பிக்கவும்';

  @override
  String get howCanWeHelp => 'நாங்கள் உங்களுக்கு எப்படி உதவ முடியும்?';

  @override
  String get issueType => 'பிரச்சினை வகை';

  @override
  String get description => 'விளக்கம்';

  @override
  String get submitTicket => 'டிக்கெட்டைச் சமர்ப்பிக்கவும்';

  @override
  String get ticketSubmitted =>
      'ஆதரவு டிக்கெட் வெற்றிகரமாக சமர்ப்பிக்கப்பட்டது!';

  @override
  String get enterDescription => 'தயவுசெய்து ஒரு விளக்கத்தை உள்ளிடவும்';

  @override
  String get descriptionTooShort => 'விளக்கம் மிகவும் சிறியது';

  @override
  String get bug => 'பிழை';

  @override
  String get suggestion => 'பரிந்துரை';

  @override
  String get other => 'மற்றவை';

  @override
  String get open => 'திறந்த';

  @override
  String get processing => 'செயலாக்கத்தில்';

  @override
  String get resolved => 'தீர்வு காணப்பட்டது';

  @override
  String get closed => 'மூடப்பட்டது';

  @override
  String get noSupportTickets => 'உங்களிடம் ஆதரவு டிக்கெட்டுகள் இல்லை.';

  @override
  String get noSupportTicketsDesc =>
      'கருத்து அல்லது பிழையைப் புகாரளிக்க + பொத்தானைத் தட்டவும்.';

  @override
  String get adminReply => 'நிர்வாகியின் பதில்';

  @override
  String get manageSupportTicket => 'ஆதரவு டிக்கெட்டை நிர்வகிக்கவும்';

  @override
  String get user => 'பயனர்';

  @override
  String get markAsProcessing => 'செயலாக்கத்தில் எனக் குறிக்கவும்';

  @override
  String get resolveAndSendReply => 'தீர்வு கண்டு பதிலை அனுப்பவும்';

  @override
  String get replyCannotBeEmpty => 'பதில் காலியாக இருக்கக்கூடாது';

  @override
  String get all => 'அனைத்தும்';

  @override
  String get active => 'செயலில்';

  @override
  String noTicketsFound(String status) {
    return '$status டிக்கெட்டுகள் எதுவும் இல்லை.';
  }

  @override
  String get report => 'அறிக்கை';

  @override
  String get error => 'பிழை';

  @override
  String get adminDashboard => 'நிர்வாக டாஷ்போர்டு';

  @override
  String get users => 'பயனர்கள்';

  @override
  String get tickets => 'டிக்கெட்டுகள்';

  @override
  String get searchByUsernameOrId => 'பயனர்பெயர் அல்லது ஐடி மூலம் தேடவும்...';

  @override
  String get errorLoadingUsers => 'பயனர்களை ஏற்றுவதில் பிழை';

  @override
  String get noRegisteredUsers => 'பதிவுசெய்யப்பட்ட பயனர்கள் யாரும் இல்லை.';

  @override
  String noUsersMatching(String query) {
    return '\"$query\" உடன் பொருந்தும் பயனர்கள் யாரும் இல்லை';
  }

  @override
  String get adminLabel => 'நிர்வாகி';

  @override
  String get userLabel => 'பயனர்';

  @override
  String get online => 'ஆன்லைன்';

  @override
  String get offline => 'ஆஃப்லைன்';

  @override
  String get telemetry => 'டெலிமெட்ரி';

  @override
  String get history => 'வரலாறு';

  @override
  String get loginFrequency7Days => 'உள்நுழைவு அதிர்வெண் (7 நாட்கள்)';

  @override
  String get noLoginActivityFound => 'உள்நுழைவு செயல்பாடு எதுவும் இல்லை.';

  @override
  String get refresh => 'புதுப்பிக்கவும்';

  @override
  String get errorLoadingLogs => 'பதிவுகளை ஏற்றுவதில் பிழை';
}
