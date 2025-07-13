import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/configs/Route/app_route.dart';

class BrandProfileScreen extends StatelessWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(AppRoute.home);
          },
          child: Text('data'),
        ),
      ),
    );
  }
}
