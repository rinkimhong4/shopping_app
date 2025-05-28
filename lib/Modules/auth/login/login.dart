import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/auth_controller.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(AuthController());
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(body: Container(child: _buildBody)),
    );
  }

  get _buildBody {
    return Container(
      height: Get.height,
      width: Get.width,
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.only(top: 90.0, left: 24, right: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please Sign In",
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Login to your account to continue shopping and manage your orders.",
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              // controller: emailCtrl,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(179, 255, 255, 255),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
