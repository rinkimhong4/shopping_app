import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

extension ListSpaceBetweenExtension on List<Widget> {
  List<Widget> withSpaceBetween({double? width, double? height}) => [
    for (int i = 0; i < length; i++) ...[
      if (i > 0) SizedBox(width: width, height: height),
      this[i],
    ],
  ];
}

void processAlert({required String message, required void Function() onTap}) {
  Get.dialog(
    barrierDismissible: false,
    LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
        bool isPortrait = screenHeight > screenWidth;

        // Calculate margins, padding, and constraints based on orientation and screen size
        double margin = screenWidth * 0.05;
        double padding =
            screenWidth *
            (isPortrait ? 0.05 : 0.02); // Smaller padding in landscape
        double maxWidth = isPortrait ? screenWidth * 0.9 : screenWidth * 0.6;
        double maxHeight = isPortrait ? screenHeight * 0.4 : screenHeight * 0.5;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
            ),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: margin),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/icon/progress.gif', scale: 7),
                    Text(
                      'inProgress'.tr,
                      // style: AppTextStyle.bold18(color: AppTheme.primaryswatch),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(fontSize: 15, color: AppColors.primary),
                    ),
                    const SizedBox(),
                    ElevatedButton(onPressed: onTap, child: Text('cancel')),
                  ].withSpaceBetween(height: 10),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

void notificationAlert(String message) {
  Get.rawSnackbar(
    padding: const EdgeInsets.only(left: 28, top: 12, bottom: 10),
    messageText: Text(
      message,
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
    isDismissible: false,
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red,
    icon: Container(
      alignment: Alignment.topRight,
      height: 18,
      width: 68,
      child: const Icon(
        Icons.error_outline_rounded,
        color: Colors.white,
        size: 18,
      ),
    ),
    margin: EdgeInsets.zero,
    snackStyle: SnackStyle.GROUNDED,
  );
}

void sucessfullyAlert({
  required String message,
  required void Function() onTap,
}) {
  Get.dialog(
    barrierDismissible: false,
    LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
        bool isPortrait = screenHeight > screenWidth;

        // Calculate margins, padding, and constraints based on orientation and screen size
        double margin = screenWidth * 0.05;
        double padding =
            screenWidth *
            (isPortrait ? 0.05 : 0.02); // Smaller padding in landscape
        double maxWidth = isPortrait ? screenWidth * 0.9 : screenWidth * 0.6;
        double maxHeight = isPortrait ? screenHeight * 0.4 : screenHeight * 0.5;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
            ),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: margin),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/icon/verified.gif', scale: 2),
                    Text(
                      'confirm'.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(fontSize: 15, color: AppColors.primary),
                    ),
                    const SizedBox(),
                    ElevatedButton(onPressed: onTap, child: Text('ok')),
                  ].withSpaceBetween(height: 10),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

class Functions {
  static void clipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.showSnackbar(
      GetSnackBar(
        message: 'Copied to clipboard',
        duration: Duration(seconds: 2),
      ),
    );
  }
}
