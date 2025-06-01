import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/configs/Route/app_route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoute.splash,
      getPages: AppRoute.pages,
    );
  }
}
