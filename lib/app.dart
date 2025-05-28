import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/auth/login/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: HomeScreen(),
      // home: SplashScreen(),
      home: LoginScreen(),
    );
  }
}
