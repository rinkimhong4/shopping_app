import 'package:flutter/material.dart';
import 'package:shopping_app/Modules/Home/Views/Start_Screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: HomeScreen(),
      home: SplashScreen(),
    );
  }
}
