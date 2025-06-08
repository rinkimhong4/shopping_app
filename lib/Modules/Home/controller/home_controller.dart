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
    var client = http.Client();
    try {
      isLoading.value = true;
      final response = await client.get(
        Uri.http('fakestoreapi.com', 'products/'),
      );
      final fetchedTShirts = tShirtModelFromJson(response.body);
      tShirtModels.assignAll(fetchedTShirts);
    } finally {
      client.close();
      isLoading.value = false;
    }
  }

  void startAutoSlide(int length) {
    Future.delayed(const Duration(seconds: 5), () {
      if (pageController.hasClients) {
        int nextPage = (currentPage.value + 1) % length;
        pageController.animateToPage(
          nextPage,
          duration: Duration(seconds: 1),
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
