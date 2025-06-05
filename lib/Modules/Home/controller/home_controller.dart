import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/Modules/Home/models/product_model.dart';
import 'package:shopping_app/core/service/api_service.dart';
import 'package:shopping_app/core/string/string_con.dart';

class HomeController extends GetxController {
  ApiService get apiService => ApiService(baseUrl: URL);
  var isLoading = true.obs;
  var currentPage = 0.obs;
  var pageController = PageController();
  var tShirtModels = <TShirtModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTShirts();
  }

  void fetchTShirts() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      if (response.statusCode == 200) {
        final List<TShirtModel> fetchedTShirts = tShirtModelFromJson(
          response.body,
        );
        tShirtModels.assignAll(fetchedTShirts);
      } else {
        Get.snackbar('Error', 'Failed to fetch products');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void startAutoSlide(int length) {
    Future.delayed(const Duration(seconds: 3), () {
      if (pageController.hasClients) {
        int nextPage = (currentPage.value + 1) % length;
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        currentPage.value = nextPage;
        startAutoSlide(length);
      }
    });
  }

  void updateCurrentPage(int index) {
    currentPage.value = index;
  }
}
