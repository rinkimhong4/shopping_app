import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/Views/Start_Screen/onboarding_screen.dart';
import 'package:shopping_app/Modules/Home/Views/Start_Screen/splash_screen.dart';
import 'package:shopping_app/Modules/Home/Views/bag/bag_screen.dart';
import 'package:shopping_app/Modules/Home/Views/home_screen.dart';
import 'package:shopping_app/Modules/Home/Views/notifications/masnory_grid_view.dart';
import 'package:shopping_app/Modules/Home/Views/notifications/notification_screen.dart';
import 'package:shopping_app/Modules/Home/Views/profile/profile_screen.dart';
import 'package:shopping_app/Modules/Home/Views/search/search_screen.dart';
import 'package:shopping_app/Modules/Home/binding/profile_binding.dart';
import 'package:shopping_app/Modules/auth/login/login.dart';
import 'package:shopping_app/Modules/auth/signup/signup.dart';
import 'package:shopping_app/Modules/items/profile/card_items/my_orders.dart';
import 'package:shopping_app/Modules/items/profile/card_items/promo_code.dart';
import 'package:shopping_app/Modules/items/profile/general_setting_profile/my_account.dart';
import 'package:shopping_app/Modules/items/profile/general_setting_profile/my_address.dart';
import 'package:shopping_app/Modules/items/profile/general_setting_profile/my_notification.dart';
import 'package:shopping_app/Modules/items/profile/general_setting_profile/payment_methods.dart';
import 'package:shopping_app/Modules/items/profile/other_setting_profile/about_us.dart';
import 'package:shopping_app/Modules/items/profile/other_setting_profile/contact_preference.dart';
import 'package:shopping_app/Modules/items/profile/other_setting_profile/customer_support.dart';
import 'package:shopping_app/Modules/items/profile/other_setting_profile/term_condition.dart';

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
  static const String generalSetting = '/generalSetting';
  static const String myAddress = '/myAddress';
  static const String myNotification = '/myNotification';
  static const String paymentMethods = '/paymentMethods';
  static const String aboutUs = '/aboutUs';
  static const String contactPreference = '/contactPreference';
  static const String customerSupport = '/customerSupport';
  static const String termCondition = '/termCondition';
  static const String myOrders = '/myOrders';
  static const String promoCode = '/promoCode';
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
    GetPage(
      name: generalSetting,
      page: () => MyAccountItems(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: myAddress,
      page: () => MyAddressItems(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: myNotification,
      page: () => MyNotificationItems(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: paymentMethods,
      page: () => PaymentMethodsItems(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: aboutUs,
      page: () => AboutUsItems(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: contactPreference,
      page: () => ContactPreferenceItems(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: customerSupport,
      page: () => CustomerSupportItems(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: termCondition,
      page: () => TermConditionItems(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: myOrders,
      page: () => MyOrdersItems(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: promoCode,
      page: () => PromoCodeItems(),
      // transition: Transition.noTransition,
      // binding: ProfileBinding(),
    ),
  ];
}
