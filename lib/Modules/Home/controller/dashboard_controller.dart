import 'package:get/get.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/core/service/local_service.dart';

class DashboardController extends GetxController {
  var userId = ''.obs;
  @override
  void onInit() {
    userId.value = LocalStorageService.instance.getString('user_id') ?? '';
    Future.delayed(const Duration(seconds: 3), () {
      if (userId.value == '') {
        Get.offAllNamed(AppRoute.login);
      } else {
        Get.offAllNamed(AppRoute.home);
      }
    });
    // print(LocalStorageService.instance.getString('user_id'));
    // LocalStorageService.instance.getString('user_id');
    super.onInit();
  }
}
