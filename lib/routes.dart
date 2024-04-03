import 'package:get/get.dart';
import 'package:knowyourself/features/learning/screens/materials/pages/course_page.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/add_mood_screen.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/activities_to_shift.dart';
import 'package:knowyourself/features/personalisation/screens/settings/pages/settings_my_space.dart';
import 'common/extras/notification_screen.dart';
import 'features/master.dart';
import 'features/personalisation/screens/profile/profile_screen.dart';
import 'features/personalisation/screens/profile/profile_setup.dart';
import 'features/personalisation/screens/settings/setting_screen.dart';
import 'common/extras/splash_screen.dart';
import 'features/auth/screens/login/login_screen.dart';
import 'features/auth/screens/pass_reset/password_reset.dart';
import 'features/auth/screens/signup/signup_screen.dart';
import 'features/auth/screens/onboard/onboard.dart';

class KRoutes{
  static const String master = '/';
  static String getMasterRoute() => master;
  static const String splash = '/splash';
  static String getSplashRoute() => splash;

  //auth screens
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String passwordReset = '/passwordReset';
  static const String profileSetup = '/profile';
  static String getOnBoardingRoute() => onBoarding;
  static String getLoginRoute() => login;
  static String getSignupRoute() => signup;
  static String getPasswordResetRoute() => passwordReset;
  static String getProfileRoute() => profileSetup;

  //settings screens
  static const String settingSpace = '/settingSpace';
  static String getSettingSpaceRoute() => settingSpace;

  static const String settings = '/settings';
  static const String profileEdit = '/profileEdit';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String help = '/help';
  static const String terms = '/terms';
  static const String privacy = '/privacy';
  static String getProfileEditRoute() => profileEdit;
  static String getSettingsRoute() => settings;
  static String getAboutRoute() => about;
  static String getContactRoute() => contact;
  static String getHelpRoute() => help;
  static String getTermsRoute() => terms;
  static String getPrivacyRoute() => privacy;

  //myspace
  static const String addMood = '/addMood';
  static String getAddMoodRoute() => addMood;


  //learning
  static const String resourcesVideo = '/resourcesVideo';
  static String getResourcesVideoRoute() => resourcesVideo;
  static const String resourcesMagazine = '/resourcesMagazine';
  static String getResourcesMagazineRoute() => resourcesMagazine;

  static const String activities = '/activities';
  static String getActivitiesRoute() => activities;

  //extras
  static const String notifications = '/notifications';
  static String getNotificationsRoute() => notifications;

  static const _defaultTransition = Transition.fadeIn;
  static const _defaultTransitionDuration = Duration(milliseconds: 500);

  static List<GetPage> routes =[
    GetPage(name: master, page: () =>  const MasterScreen(),
        transition: Transition.fadeIn , transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(name: splash, page: () => const SplashScreen(), transition: Transition.fadeIn),
    GetPage(name: onBoarding, page: () => const OnBoard(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
    GetPage(name: login, page: () => const LoginScreen(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
    GetPage(name: signup, page: () => const SignUpScreen(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
    GetPage(name: passwordReset, page: () => const PasswordResetScreen(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
    GetPage(name: profileSetup, page: () => const ProfileSetupScreen(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
    GetPage(name: settings, page: () => const SettingScreen(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
    GetPage(name: profileEdit, page: () => const ProfileEditScreen(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
    GetPage(name: notifications, page: () => const NotificationsScreen(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
    GetPage(name: addMood, page: () => const AddMoodScreen(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
    GetPage(name: activities, page: () => ActivitiesToShiftScreen(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
    GetPage(name: settingSpace, page: () => const SettingsMySpace(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
    // GetPage(name: resourcesVideo, page: () =>  ResourcesVideoPage(),
    //     transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    // ),
    GetPage(name: resourcesMagazine, page: () =>  const CoursePage(),
        transition: _defaultTransition , transitionDuration: _defaultTransitionDuration
    ),
  ];
}