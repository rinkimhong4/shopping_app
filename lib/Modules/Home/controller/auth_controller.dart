import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confPasswordCtrl = TextEditingController();
  final isLoading = false.obs;

  final _supabase = Supabase.instance.client;

  Future<void> signUp(String email, String password) async {
    try {
      //
      isLoading.value = true;
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        isLoading.value = false;
        Get.toNamed(AppRoute.home);
      }
    } catch (e) {
      if (e is AuthException) {
        Get.snackbar('Error', e.message);
        // emailCtrl.clear();
        passwordCtrl.clear();
        confPasswordCtrl.clear();
      } else {
        Get.snackbar('Error', 'An unexpected error occurred');
      }
      // debugPrint(e.toString());
    }
  }

  // Validation functions
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    // Check for at least one digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check for at least one special character
    // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password must contain at least one special character';
    // }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordCtrl.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confPasswordCtrl.dispose();
    super.onClose();
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      Get.offAllNamed(AppRoute.login);
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: ${e.toString()}');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw 'Please fill in all fields';
      }

      isLoading.value = true;

      final response = await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      if (response.user?.emailConfirmedAt == null) {
        throw 'Please verify your email first';
      }

      Get.offAllNamed(AppRoute.home);
    } on AuthException catch (e) {
      String message = _parseAuthError(e);
      Get.snackbar('Login Failed', message);
    } catch (e) {
      debugPrint('Login error: $e');
      Get.snackbar('Error', 'Failed to sign in. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  String _parseAuthError(AuthException e) {
    switch (e.message) {
      case 'Invalid login credentials':
        return 'Incorrect email or password';
      case 'Email not confirmed':
        return 'Please verify your email first';
      case 'Too many requests':
        return 'Too many attempts. Try again later';
      default:
        return e.message;
    }
  }

  User? get currentUser => _supabase.auth.currentUser;
}
