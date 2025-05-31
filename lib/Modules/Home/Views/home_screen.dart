import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final authController = Get.put(AuthController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Get.find<AuthController>().signOut();
              authController.emailCtrl.clear();
              authController.passwordCtrl.clear();
              // Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Container(color: Colors.white, child: Center(child: Text('Hello'))),
    );
  }
}
