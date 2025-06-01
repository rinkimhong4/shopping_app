import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _currentPage = 0.obs;
  final PageController _pageController = PageController();
  Timer? _timer;

  PageController get pageController => _pageController;
  int get currentPage => _currentPage.value;

  void startAutoSlide(int itemCount) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_pageController.hasClients && itemCount > 0) {
        int nextPage = (_currentPage.value.round() + 1) % itemCount;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
        _currentPage.value = nextPage;
      }
    });
  }

  void updateCurrentPage(int index) {
    _currentPage.value = index;
  }

  @override
  void onClose() {
    _timer?.cancel();
    _pageController.dispose();
    super.onClose();
  }
}
