import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final _supabase = Supabase.instance.client;

  RxString username = ''.obs;

  Future<void> loadProfile() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    final response =
        await _supabase.from('profiles').select().eq('id', userId).single();
    username.value = response['username'] ?? '';
  }

  Future<void> updateProfile(String newUsername) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase.from('profiles').upsert({
      'id': userId,
      'username': newUsername,
      'created_at': DateTime.now().toIso8601String(),
    });

    username.value = newUsername;
  }
}
