import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoute.splash,
      getPages: AppRoute.pages,
    );
  }
}
