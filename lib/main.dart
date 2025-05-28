import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  final url = dotenv.env['URL'];
  final anonKey = dotenv.env['ANON_KEY'];
  await Supabase.initialize(url: url!, anonKey: anonKey!);

  runApp(MyApp());
}
