import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/core/service/local_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confPasswordCtrl = TextEditingController();
  final isLoading = false.obs;

  final _supabase = Supabase.instance.client;

  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await _supabase.auth.signUp(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );

      if (response.user != null) {
        isLoading.value = false;
        Get.offAndToNamed(AppRoute.home);
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Signup Failed',
          'Something went wrong. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on AuthException catch (e) {
      isLoading.value = false;
      // Optional: custom message for known cases
      String message =
          e.message.contains("already registered")
              ? "This email is already in use."
              : e.message;

      Get.snackbar(
        'Signup Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      emailCtrl.clear();
      passwordCtrl.clear();
      confPasswordCtrl.clear();
    } catch (e) {
      isLoading.value = false;

      debugPrint('Unexpected error: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
      await LocalStorageService.instance.remove('user_id');
      Get.offAllNamed(AppRoute.login);
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: ${e.toString()}');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await _supabase.auth.signInWithPassword(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );

      if (response.session != null) {
        await LocalStorageService.instance.setString(
          'user_id',
          response.user?.id ?? '',
        );

        isLoading.value = false;
        Get.offAndToNamed(AppRoute.home);
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Login Failed',
          'Invalid email or password.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on AuthException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Login Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      debugPrint('Unexpected error: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  User? get currentUser => _supabase.auth.currentUser;
}
