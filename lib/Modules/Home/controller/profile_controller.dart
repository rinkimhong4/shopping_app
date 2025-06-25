import 'package:get/get.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final _supabase = Supabase.instance.client;

  RxString username = ''.obs;
  RxString email = ''.obs;

  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        Get.offAndToNamed(AppRoute.login);
        return null;
      }

      final response =
          await _supabase
              .from('profiles')
              .select('*')
              .eq('id', user.id)
              .maybeSingle();

      if (response == null) {
        // Create new profile with both username and email
        final newProfile =
            await _supabase
                .from('profiles')
                .insert({
                  'id': user.id,
                  'username': user.email?.split('@')[0] ?? 'Guest',
                  'email': user.email ?? '',
                  'created_at': DateTime.now().toIso8601String(),
                })
                .select()
                .single();
        return newProfile;
      }
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<void> loadProfile() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    final response =
        await _supabase.from('profiles').select().eq('id', userId).single();

    username.value = response['username'] ?? '';
    email.value = response['email'] ?? _supabase.auth.currentUser?.email ?? '';
  }

  Future<void> updateProfile(String newUsername) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase.from('profiles').upsert({
      'id': userId,
      'username': newUsername,
      'updated_at': DateTime.now().toIso8601String(),
    });
    username.value = newUsername;
  }
}
