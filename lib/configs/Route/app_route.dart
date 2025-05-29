import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/Views/Start_Screen/onboarding_screen.dart';
import 'package:shopping_app/Modules/Home/Views/Start_Screen/splash_screen.dart';
import 'package:shopping_app/Modules/Home/Views/home_screen.dart';
import 'package:shopping_app/Modules/auth/login/login.dart';
import 'package:shopping_app/Modules/auth/signup/signup.dart';

class AppRoute {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';

  static final pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: signup, page: () => const SignupScreen()),
  ];
}
