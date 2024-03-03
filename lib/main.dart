import 'dart:math';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:knowyourself/provider/MySpace/question_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/hive%20boxes/journal_box.dart';
import 'package:knowyourself/notification%20manager/notification_manager.dart';
import 'package:knowyourself/provider/Extras/user_data_provider.dart';
import 'package:knowyourself/provider/RSS%20Reader/rss_reader_provider.dart';
import 'package:knowyourself/provider/ToDo/celebration_provider.dart';
import 'package:knowyourself/provider/ToDo/status_provider.dart';
import 'package:knowyourself/provider/ToDo/to_do_provider.dart';
import 'package:knowyourself/provider/User/points_provider.dart';
import 'package:knowyourself/provider/journal/journal_provider.dart';
import 'package:knowyourself/provider/journal/journal_editor_provider.dart';
import 'package:knowyourself/screens/Extras/Fingerprint%20Screen/fingerprint_screen.dart';
import 'package:knowyourself/screens/Extras/Onboarding%20Screen/onboarding_screen.dart';
import 'package:knowyourself/screens/Main%20Screen/main_screen.dart';
import 'package:knowyourself/utils/affirmations.dart';
import 'package:knowyourself/utils/app_info.dart';
import 'package:knowyourself/utils/pref.dart';
import 'package:knowyourself/provider/App%20State/app_state_provider.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:timezone/data/latest_10y.dart';
import 'package:workmanager/workmanager.dart';

import 'auth/auth_service.dart';

@pragma('vm:entry-point')
callbackDispatcher() {
  DartPluginRegistrant.ensureInitialized();
  Workmanager().executeTask((task, inputData) async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day, 9);
    final end = DateTime(now.year, now.month, now.day, 21); // 9 pm
    await SharedPreferencesHelper.init();

    if (now.isAfter(start) &&
        now.isBefore(end) &&
        SharedPreferencesHelper.getNotificationPermission()) {
      final random = Random();
      final quoteIndex = random.nextInt(affirmations.length);
      String quote = affirmations[quoteIndex];
      final titleIndex = random.nextInt(quotesTitle.length);
      String title = quotesTitle[titleIndex];
      NotificationManager.showNotification(title: title, body: quote);
    }

    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final authService = AuthService();
  // bool isUserSignedIn = await authService.isUserSignedIn();
  initializeTimeZones();
  final dir = await getApplicationDocumentsDirectory();
  await SharedPreferencesHelper.init();
  Hive.init(dir.path);
  AppInfo.init();
  JournalHiveBox.init(dateTime: DateTime.now());
  // NotificationManger.init();
  // Workmanager().initialize(
  //   callbackDispatcher, // The top level function, aka callbackDispatcher
  // );
  // Workmanager().registerPeriodicTask(
  //   "quote-notification",
  //   "QuoteNotification",
  //   frequency: const Duration(hours: 2),
  // );
  // BackGroundManager.init();
  GoogleFonts.config.allowRuntimeFetching = true;
  if (SharedPreferencesHelper.getSavedTheme() == 0) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor: Colors.red,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: kLightModeBottomNavBarColor,
          systemNavigationBarIconBrightness: Brightness.dark
      ),
    );
  } else {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor: Colors.blue,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: kDarkModeScaffoldColor,
          systemNavigationBarIconBrightness: Brightness.light),
    );
  }
  runApp( const MyApp(
    // isUserSignedIn: isUserSignedIn
  ));
}

class MyApp extends StatefulWidget {
  // final bool isUserSignedIn;
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // User? _user;

  @override
  void initState() {
    super.initState();
    // checkUserLoggedIn();
  }

  // void checkUserLoggedIn() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user = auth.currentUser;
  //   if (user != _user) {
  //     setState(() {
  //       _user = user;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JournalProvider>(
          create: (BuildContext context) {
            return JournalProvider();
          },
        ),
        ChangeNotifierProvider<JournalEditorProvider>(
          create: (BuildContext context) {
            return JournalEditorProvider();
          },
        ),
        ChangeNotifierProvider<AppStateProvider>(
          create: (BuildContext context) {
            return AppStateProvider();
          },
        ),
        ChangeNotifierProvider<PointsProvider>(
          create: (BuildContext context) {
            return PointsProvider();
          },
        ),
        ChangeNotifierProvider<TodoProvider>(
          create: (BuildContext context) {
            return TodoProvider();
          },
        ),
        ChangeNotifierProvider<CelebrationProvider>(
          create: (BuildContext context) {
            return CelebrationProvider();
          },
        ),
        ChangeNotifierProvider<UserDataProvider>(
          create: (BuildContext context) {
            return UserDataProvider();
          },
        ),
        ChangeNotifierProvider<RSSReaderProvider>(
          create: (BuildContext context) {
            return RSSReaderProvider();
          },
        ),
        ChangeNotifierProvider<StatusProvider>(
          create: (BuildContext context) {
            return StatusProvider();
          },
        ),
        ChangeNotifierProvider<QuestionsProvider>(
            create:(BuildContext context){
              return QuestionsProvider();
            }
        )
      ],
      child: ScreenUtilInit(
        builder: (BuildContext context, Widget? child) {
          return Consumer<AppStateProvider>(
              builder: (BuildContext context, theme, Widget? child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'KYB',
                  darkTheme: ThemeData.dark().copyWith(
                    primaryColor: kPrimaryColor,
                    canvasColor: Colors.transparent,
                    cardColor: kDarkModeCardColor,
                    scaffoldBackgroundColor: kDarkModeScaffoldColor,
                    iconTheme: const IconThemeData(color: Colors.white),
                    chipTheme: const ChipThemeData(
                        backgroundColor: Color(0xFF3C3C56),
                        secondarySelectedColor: Color(0xFF323248),
                        selectedColor: Colors.black),
                    textTheme: GoogleFonts.poppinsTextTheme(
                      Theme.of(context).textTheme,
                    ).apply(
                      bodyColor: Colors.white,
                      displayColor: Colors.white,
                    ),
                  ),
                  theme: ThemeData.light().copyWith(
                    primaryColor: kPrimaryColor,
                    scaffoldBackgroundColor: kLightModeScaffoldColor,
                    canvasColor: Colors.transparent,
                    cardColor: kLightModeCardColor,
                    chipTheme: const ChipThemeData(
                        backgroundColor: Color(0xFFE6E6EB),
                        secondarySelectedColor: Color(0xFFE4E4E4),
                        selectedColor: Color(0xFFFFD9E9)),
                    iconTheme: const IconThemeData(color: Colors.black),
                    textTheme: GoogleFonts.poppinsTextTheme(
                      Theme.of(context).textTheme,
                    ).apply(
                      bodyColor: kPrimaryTextColor,
                      displayColor: kPrimaryTextColor,
                    ),
                  ),
                  themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  home: onLoggedin(),
                );
              });
        },
      ),
    );
  }
}

class onLoggedin extends StatelessWidget {
  const onLoggedin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainScreen();
          } else {
            return const OnBoardingScreen();
          }
        }
    );
  }
}
