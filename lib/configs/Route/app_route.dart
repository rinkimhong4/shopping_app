import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/Views/Start_Screen/splash_screen.dart';
import 'package:shopping_app/Modules/Home/Views/home_screen.dart';
import 'package:shopping_app/Modules/auth/login/login.dart';
import 'package:shopping_app/Modules/auth/signup/signup.dart';

class AppRoute {
  static const String splash = '/splash';
  // static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';

  static final pages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    // GetPage(
    //   name: onboarding,
    //   page: () => OnboardingScreen(),
    //   transition: Transition.fade,
    // ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: signup,
      page: () => SignupScreen(),
      transition: Transition.noTransition,
    ),
  ];
}
