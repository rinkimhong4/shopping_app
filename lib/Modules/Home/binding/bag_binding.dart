import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/bag_controller.dart';

class BagBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BagController>(() => BagController());
  }
}
