// import 'package:get/get.dart';
// import 'package:shopping_app/Modules/Home/models/product_model.dart';
// import 'package:shopping_app/core/service/api_service.dart';
// import 'package:shopping_app/core/string/string_con.dart';

// class SearchControllerGetX extends GetxController {
//   ApiService get apiService => ApiService(baseUrl: URL);
//   var isLoading = true.obs;
//   RxList<TShirtModel> shirtModels = <TShirtModel>[].obs; // Changed to RxList

//   Future<void> loadingClothing() async {
//     isLoading.value = true;
//     // Assuming API returns a list of TShirtModel
//     try {
//       final data = await apiService.callApi<List<dynamic>>(
//         // Expect a list from the API
//         endpoint: PRODUCT,
//         body: {},
//         fromJson:
//             (data) =>
//                 (data as List)
//                     .map((item) => TShirtModel.fromJson(item))
//                     .toList(), // Map each item to TShirtModel
//       );
//       shirtModels.value =
//           data.cast<TShirtModel>(); // Assign the list to shirtModels.value
//     } catch (e) {
//       shirtModels.value = [];
//     }
//     isLoading.value = false;
//   }

//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     await loadingClothing(); // Call the API function and await its result
//   }
// }
