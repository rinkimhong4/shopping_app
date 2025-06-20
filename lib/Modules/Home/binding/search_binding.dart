import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchControllerGetX>(() => SearchControllerGetX());
  }
}
