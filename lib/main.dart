// @dart=2.9
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gmail_alarm/utils/gmail_app_util.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:gmail_alarm/View_Model/home_view_model.dart';
import 'package:gmail_alarm/View_Model/sign_in_view_model.dart';
import 'package:gmail_alarm/model/background_fetch_wrapper.dart';
import 'package:gmail_alarm/utils/locator.dart';
// @DEL
// import 'package:gmail_alarm/utils/prefer.dart';
import 'package:gmail_alarm/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'View_Model/gmail_label_view_model.dart';
import 'model/ad_state.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Wait for Firebase to initialize and set `_initialized` state to true
  await Firebase.initializeApp();
  final mobileAdsInstance = MobileAds.instance.initialize();
  final adState = AdState(mobileAdsInstance);

  // @DEL
  // Prefs.init(); from preffer.dart
  setLocator();
  var gmailLabelViewModel = locator<GmailLabelViewModel>();
  gmailLabelViewModel.adState = adState;

  //ignore: omit_local_variable_types
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  //ignore: omit_local_variable_types
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  
  // final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  // final MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
  //ignore: omit_local_variable_types
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid
    // ,iOS: initializationSettingsIOS
    // ,macOS: initializationSettingsMacOS
  );
  // flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: GMailAppUtil.selectNotification);
  flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);

  BackgroundFetchWrapper.notifier = flutterLocalNotificationsPlugin;
  BackgroundFetchWrapper.initPlatformState(gmailLabelViewModel);

  runApp(MultiProvider(
    child: MyApp(),
    providers: [
      ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel(),),
      ChangeNotifierProvider<GmailLabelViewModel> (create: (_) => GmailLabelViewModel(),),
    ],
  ));

  // Register to receive BackgroundFetch events after app is terminated.
  // Requires {stopOnTerminate: false, enableHeadless: true}
  await BackgroundFetch.registerHeadlessTask(BackgroundFetchWrapper.backgroundFetchHeadlessTask);
  debugPrint('[BackgroundFetch] backgroundFetchHeadlessTask queued @ ${DateTime.now()}');
}

//Future<dynamic> selectNotification(String? payload) // When the nullable features enabled
Future<dynamic> selectNotification(String payload) async {
  BackgroundFetchWrapper.gmailLabelViewModel.alarmOn = false;
  GMailAppUtil.stopAlarm();
  //await Navigator.push(context, MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)));
  if (Platform.isAndroid) {
    //ignore: omit_local_variable_types
    AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      category: 'android.intent.category.APP_EMAIL',
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    await intent.launch().catchError((e) {debugPrint('selectNotification Error:${e}');});
  } else if (Platform.isIOS) {
    await launch('message://').catchError((e){debugPrint('selectNotification Error:${e}');});
  }
}

class MyApp extends StatefulWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;
  // late Locale locale;
  bool localeLoaded = false;

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      debugPrint('error on Firebase Initialization: ${e}');
      setState(() {
        _error = true;
      });
    }
  }
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
    print('initState()');

    //MyApp.setLocale(context, locale);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //systemNavigationBarColor: Colors.grey[400],
        systemNavigationBarColor: Colors.lightBlue[200],
		//statusBarColor: Styles.blueColor,
        statusBarIconBrightness:
        Brightness.light //or set color with: Color(0xFF0000FF)
    ));
    return ChangeNotifierProvider<SignInViewModel>(
      // @KEN
      // builder: (context) => SignInViewModel(),
      create: (context) => SignInViewModel(),
      child: Center(
        child: MaterialApp(
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.onGenerateRoute,
          theme: ThemeData(
            primaryColor:Colors.black,
            fontFamily: 'FA',
          ),
        ),
      ),
    );
  }
}
