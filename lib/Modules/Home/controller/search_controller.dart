import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/Modules/Home/models/product_model_api.dart';

class SearchControllerGetX extends GetxController {
  var tShirtModels = <TShirtModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchTShirts({bool isRefresh = false}) async {
    var client = http.Client();
    try {
      isLoading.value = true;
      final response = await client.get(
        Uri.http('fakestoreapi.com', 'products/'),
      );
      if (response.statusCode == 200) {
        final fetchedTShirts = tShirtModelFromJson(response.body);
        tShirtModels.assignAll(fetchedTShirts);
      } else {
        Get.snackbar('Error', 'Failed to fetch products');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      client.close();
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchTShirts();
  }
}
