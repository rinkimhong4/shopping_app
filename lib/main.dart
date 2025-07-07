import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/app_theme_controller.dart';
import 'package:shopping_app/Modules/Home/controller/auth_controller.dart';
import 'package:shopping_app/Modules/Home/controller/home_controller.dart';
import 'package:shopping_app/Modules/Home/controller/profile_controller.dart';
import 'package:shopping_app/app.dart';
import 'package:shopping_app/core/service/local_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageService.instance.init();

  await dotenv.load(fileName: ".env");
  final url = dotenv.env['URL'];
  final anonKey = dotenv.env['ANON_KEY'];
  await Supabase.initialize(url: url!, anonKey: anonKey!);
  Get.put(ThemeController());
  Get.put(ProfileController());
  Get.put(AuthController());
  Get.put(HomeController());

  runApp(MyApp());
}
