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
  String get save => 'సేవ్ చేయండి';

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

  @override
  String get systemEnvironment => 'సిస్టమ్ పర్యావరణం';

  @override
  String get temperature => 'ఉష్ణోగ్రత';

  @override
  String get humidity => 'తేమ';

  @override
  String get climateAnalysis => 'వాతావరణ విశ్లేషణ';

  @override
  String get enableNotificationsDesc =>
      'క్లిష్టమైన తేమ స్థాయిల కోసం హెచ్చరికలను స్వీకరించండి';

  @override
  String get autoModeByDefaultDesc =>
      'కొత్త వాల్వ్‌లు ఆటోమేటిక్ మోడ్‌లో ప్రారంభమవుతాయి';

  @override
  String get seconds => 'సెకన్లు';

  @override
  String get sec => 'సెకన్';

  @override
  String get appDescription => 'స్వయంప్రతిపత్త కొండ ప్రాంత నీటిపారుదల వ్యవస్థ';

  @override
  String get testConnectionDesc => 'ESP32 కనెక్టివిటీని ధృవీకరించండి';

  @override
  String get testingConnection => 'కనెక్షన్‌ని పరీక్షిస్తోంది...';

  @override
  String get connectionTest => 'కనెక్షన్ పరీక్ష';

  @override
  String get connectionSuccessful =>
      'ESP32 కనెక్షన్ విజయవంతమైంది!\nలేటెన్సీ: 45ms';

  @override
  String get notProvided => 'అందించబడలేదు';

  @override
  String get notAvailable => 'అందుబాటులో లేదు';

  @override
  String get roleUser => 'వినియోగదారు';

  @override
  String get unknownId => 'తెలియని ID';

  @override
  String get accountInformation => 'ఖాతా సమాచారం';

  @override
  String get role => 'పాత్ర';

  @override
  String get memberSince => 'సభ్యత్వ తేదీ';

  @override
  String get userId => 'వినియోగదారు ID';

  @override
  String get userIdCopied => 'వినియోగదారు ID క్లిప్‌బోర్డ్‌కు కాపీ చేయబడింది';

  @override
  String get mySupportTickets => 'నా మద్దతు టిక్కెట్లు';

  @override
  String get mySupportTicketsDesc =>
      'ఫీడ్‌బ్యాక్ లేదా బగ్ నివేదికలను వీక్షించండి మరియు సృష్టించండి';

  @override
  String get logout => 'లాగ్ అవుట్';

  @override
  String get terraceZone => 'టెర్రస్ జోన్';

  @override
  String get waterFlowRate => 'నీటి ప్రవాహ రేటు';

  @override
  String get pump => 'పంప్';

  @override
  String get litersPerMinute => 'లీ/నిమి';

  @override
  String get statusFlowing => 'ప్రవహిస్తోంది';

  @override
  String get statusPumpOnNoFlow => 'పంప్ ఆన్ / ప్రవాహం లేదు';

  @override
  String get statusStandby => 'స్టాండ్‌బై';

  @override
  String get editName => 'పేరును సవరించండి';

  @override
  String get enterNewName => 'కొత్త పేరును నమోదు చేయండి';

  @override
  String get cancel => 'రద్దు చేయండి';

  @override
  String get nameUpdatedSuccessfully => 'పేరు విజయవంతంగా నవీకరించబడింది';

  @override
  String get nameCannotBeEmpty => 'పేరు ఖాళీగా ఉండకూడదు';

  @override
  String get createAccount => 'ఖాతాను సృష్టించండి';

  @override
  String get accountCreated => 'ఖాతా విజయవంతంగా సృష్టించబడింది!';

  @override
  String get joinGreenGrid => 'GreenGrid Hillలో చేరండి';

  @override
  String get createAccountDesc => 'ప్రారంభించడానికి మీ ఖాతాను సృష్టించండి';

  @override
  String get displayName => 'ప్రదర్శన పేరు';

  @override
  String get enterDisplayName => 'మీ పేరును నమోదు చేయండి';

  @override
  String get confirmPassword => 'పాస్‌వర్డ్‌ను ధృవీకరించండి';

  @override
  String get reEnterPassword => 'మీ పాస్‌వర్డ్‌ను మళ్లీ నమోదు చేయండి';

  @override
  String get alreadyHaveAccount => 'ఇప్పటికే ఖాతా ఉందా?';

  @override
  String get resetPassword => 'పాస్‌వర్డ్ రీసెట్ చేయండి';

  @override
  String get passwordResetSent =>
      'పాస్‌వర్డ్ రీసెట్ ఇమెయిల్ పంపబడింది! మీ ఇన్‌బాక్స్‌ని తనిఖీ చేయండి.';

  @override
  String get enterEmailToReset =>
      'రీసెట్ సూచనలను అందుకోవడానికి మీ ఇమెయిల్‌ను నమోదు చేయండి';

  @override
  String get enterRegisteredEmail => 'మీ రిజిస్టర్డ్ ఇమెయిల్‌ను నమోదు చేయండి';

  @override
  String get sendResetLink => 'రీసెట్ లింక్‌ను పంపండి';

  @override
  String get rememberPassword => 'మీ పాస్‌వర్డ్ గుర్తుందా?';

  @override
  String get appTagline => 'స్వయంప్రతిపత్త కొండ ప్రాంత నీటిపారుదల';

  @override
  String get enterEmail => 'మీ ఇమెయిల్‌ను నమోదు చేయండి';

  @override
  String get enterPassword => 'మీ పాస్‌వర్డ్‌ను నమోదు చేయండి';

  @override
  String increasing(String value) {
    return 'పెరుగుతోంది +$value లీ/రోజు';
  }

  @override
  String decreasing(String value) {
    return 'తగ్గుతోంది $value లీ/రోజు';
  }

  @override
  String get stable => 'స్థిరంగా ఉంది';

  @override
  String get avg => 'సగటు';

  @override
  String get range => 'పరిధి';

  @override
  String get liters => 'లీటర్లు';

  @override
  String get hourOfDay => 'రోజు గంట (24గం)';

  @override
  String get saved => 'పొదుపు చేయబడింది';

  @override
  String get flowLevel => 'ప్రవాహ స్థాయి';

  @override
  String get monthlyTotal => 'నెలవారీ మొత్తం';

  @override
  String get dailyUsage => 'రోజువారీ వినియోగం';

  @override
  String get activations => 'సక్రియలు';

  @override
  String get waitingForSensor => 'సెన్సార్ కోసం వేచి ఉంది...';

  @override
  String get confirmLogout => 'లాగ్ అవుట్‌ని ధృవీకరించండి';

  @override
  String get logoutConfirmationDesc =>
      'GreenGrid మీ సంరక్షణతో ఉత్తమంగా పనిచేస్తుంది. మీరు ఖచ్చితంగా సిస్టమ్ నుండి నిష్క్రమించాలనుకుంటున్నారా?';

  @override
  String get newTicket => 'కొత్త టికెట్';

  @override
  String get submitFeedback => 'అభిప్రాయం / టికెట్ సమర్పించండి';

  @override
  String get howCanWeHelp => 'మేము మీకు ఎలా సహాయం చేయగలము?';

  @override
  String get issueType => 'సమస్య రకం';

  @override
  String get description => 'వివరణ';

  @override
  String get submitTicket => 'టికెట్ సమర్పించు';

  @override
  String get ticketSubmitted => 'మద్దతు టికెట్ విజయవంతంగా సమర్పించబడింది!';

  @override
  String get enterDescription => 'దయచేసి వివరణను నమోదు చేయండి';

  @override
  String get descriptionTooShort => 'వివరణ చాలా చిన్నదిగా ఉంది';

  @override
  String get bug => 'బగ్';

  @override
  String get suggestion => 'సూచన';

  @override
  String get other => 'ఇతర';

  @override
  String get open => 'ఓపెన్';

  @override
  String get processing => 'ప్రాసెసింగ్';

  @override
  String get resolved => 'పరిష్కరించబడింది';

  @override
  String get closed => 'మూసివేయబడింది';

  @override
  String get noSupportTickets => 'మీకు ఎటువంటి మద్దతు టిక్కెట్లు లేవు.';

  @override
  String get noSupportTicketsDesc =>
      'అభిప్రాయాన్ని లేదా బగ్‌ని నివేదించడానికి + బటన్‌ను నొక్కండి.';

  @override
  String get adminReply => 'అడ్మిన్ ప్రత్యుత్తరం';

  @override
  String get manageSupportTicket => 'మద్దతు టికెట్‌ను నిర్వహించండి';

  @override
  String get user => 'వినియోగదారు';

  @override
  String get markAsProcessing => 'ప్రాసెసింగ్‌గా గుర్తించు';

  @override
  String get resolveAndSendReply => 'పరిష్కరించి ప్రత్యుత్తరం పంపు';

  @override
  String get replyCannotBeEmpty => 'ప్రత్యుత్తరం ఖాళీగా ఉండకూడదు';

  @override
  String get all => 'అన్నీ';

  @override
  String get active => 'క్రియాశీల';

  @override
  String noTicketsFound(String status) {
    return '$status టిక్కెట్లు ఏవీ కనుగొనబడలేదు.';
  }

  @override
  String get report => 'నివేదిక';

  @override
  String get error => 'లోపం';

  @override
  String get adminDashboard => 'అడ్మిన్ డాష్‌బోర్డ్';

  @override
  String get users => 'వినియోగదారులు';

  @override
  String get tickets => 'టిక్కెట్లు';

  @override
  String get searchByUsernameOrId =>
      'వినియోగదారు పేరు లేదా ID ద్వారా వెతకండి...';

  @override
  String get errorLoadingUsers => 'వినియోగదారులను లోడ్ చేయడంలో లోపం';

  @override
  String get noRegisteredUsers => 'నమోదిత వినియోగదారులు కనుగొనబడలేదు.';

  @override
  String noUsersMatching(String query) {
    return '\"$query\"కి సరిపోయే వినియోగదారులు కనుగొనబడలేదు';
  }

  @override
  String get adminLabel => 'అడ్మిన్';

  @override
  String get userLabel => 'యూజర్';

  @override
  String get online => 'ఆన్‌లైన్';

  @override
  String get offline => 'ఆఫ్‌లైన్';

  @override
  String get telemetry => 'టెలిమెట్రీ';

  @override
  String get history => 'చరిత్ర';

  @override
  String get loginFrequency7Days => 'లాగిన్ ఫ్రీక్వెన్సీ (7 రోజులు)';

  @override
  String get noLoginActivityFound => 'లాగిన్ కార్యాచరణ ఏదీ కనుగొనబడలేదు.';

  @override
  String get refresh => 'రిఫ్రెష్';

  @override
  String get errorLoadingLogs => 'లాగ్‌లను లోడ్ చేయడంలో లోపం';
}
