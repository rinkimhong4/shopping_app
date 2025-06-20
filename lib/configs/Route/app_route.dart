import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/Views/Start_Screen/onboarding_screen.dart';
import 'package:shopping_app/Modules/Home/Views/Start_Screen/splash_screen.dart';
import 'package:shopping_app/Modules/Home/Views/bag/bag_screen.dart';
import 'package:shopping_app/Modules/Home/Views/home_screen.dart';
import 'package:shopping_app/Modules/Home/Views/notifications/masory_grid_view.dart';
import 'package:shopping_app/Modules/Home/Views/notifications/notification_screen.dart';
import 'package:shopping_app/Modules/Home/Views/profile/profile_screen.dart';
import 'package:shopping_app/Modules/Home/Views/search/search_screen.dart';
import 'package:shopping_app/Modules/Home/binding/profile_binding.dart';
import 'package:shopping_app/Modules/auth/login/login.dart';
import 'package:shopping_app/Modules/auth/signup/signup.dart';

class AppRoute {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String signup = '/signup';
  static const String bagScreen = '/bagScreen';
  static const String searchScreen = '/searchScreen';
  static const String profile = '/profile';
  static const String notification = '/notification';
  static const String masonry = '/masonry';
  // MasonryGridViewWidget

  static final pages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: onboarding,
      page: () => OnboardingScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      transition: Transition.noTransition,
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

    GetPage(
      name: bagScreen,
      page: () => BagScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: searchScreen,
      page: () => SearchScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: profile,
      page: () => ProfileScreen(),
      transition: Transition.noTransition,
      binding: ProfileBinding(),
    ),
    GetPage(
      name: notification,
      page: () => CustomLiquidPullToRefresh(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: masonry,
      page: () => MasonryGridViewWidget(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
  ];
}
