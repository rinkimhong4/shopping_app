import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/models/product_model_api.dart';
import 'package:shopping_app/core/service/api_service.dart';
import 'package:shopping_app/core/string/string_con.dart';

class SearchControllerGetX extends GetxController {
  ApiService get apiService => ApiService(baseUrl: BASE_URL);
  var isLoading = true.obs;
  RxList<TShirtModel> shirtModels = <TShirtModel>[].obs;

  Future<void> loadingClothing() async {
    isLoading.value = true;

    try {
      final data = await apiService.callApi<List<dynamic>>(
        endpoint: PRODUCT,
        body: {},
        fromJson:
            (data) =>
                (data as List)
                    .map((item) => TShirtModel.fromJson(item))
                    .toList(),
      );
      shirtModels.value = data.cast<TShirtModel>();
    } catch (e) {
      shirtModels.value = [];
    }
    isLoading.value = false;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadingClothing();
  }
}
