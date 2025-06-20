import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shopping_app/configs/Route/app_route.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) {
        Get.offAllNamed(AppRoute.home);
      } else {
        Get.offAllNamed(AppRoute.onboarding);
      }
    });
  }
}
