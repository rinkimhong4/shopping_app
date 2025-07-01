import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class BagController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final Rx<Color> appBarColor = AppColors.accent.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.offset > 40) {
        appBarColor.value = AppColors.accent;
      } else {
        appBarColor.value = AppColors.accent;
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
