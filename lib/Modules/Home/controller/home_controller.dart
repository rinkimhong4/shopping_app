import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shopping_app/Modules/Home/models/product_model_api.dart';
import 'package:shopping_app/core/data/home_data.dart';
import 'package:shopping_app/core/service/api_service.dart';
import 'package:shopping_app/core/string/string_con.dart';

class HomeController extends GetxController {
  ApiService get apiService => ApiService(baseUrl: BASE_URL);

  var isLoading = true.obs;
  var currentPage = 0.obs;
  var isRefreshing = false.obs;

  // Controllers
  var pageController = PageController();
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  // Data
  var tShirtModels = <TShirtModel>[].obs;
  var page = 1;
  var hasMore = true;
  var errorOccurred = false.obs;

  @override
  void onInit() {
    super.onInit();
    initialLoad();
  }

  @override
  void onClose() {
    pageController.dispose();
    refreshController.dispose();
    super.onClose();
  }

  Future<void> initialLoad() async {
    try {
      isLoading.value = true;
      await fetchTShirts();
    } catch (e) {
      errorOccurred.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  //
  Future<void> fetchTShirts({bool isRefresh = false}) async {
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

  /// Pull-down refresh handler
  Future<void> onRefresh() async {
    await fetchTShirts(isRefresh: true);
    refreshController.refreshCompleted();
    startAutoSlide(HomeDataSlider.bannerItems.length);
  }

  Future<void> onLoading() async {
    if (!errorOccurred.value) {
      await fetchTShirts();
    } else {
      refreshController.loadFailed();
    }
  }

  /// Banner auto-slide functionality
  void startAutoSlide(int length) {
    Future.delayed(Duration(seconds: 5), () {
      if (pageController.hasClients &&
          !isLoading.value &&
          !isRefreshing.value) {
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

  Future<void> forceRefresh() async {
    refreshController.requestRefresh();
    await onRefresh();
  }
}
