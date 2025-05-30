import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confPasswordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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

  void submitCommand(BuildContext context) {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      loginCommand(context);
    }
  }

  void loginCommand(BuildContext context) {
    // This is just a demo, so no actual login here.
    final snackbar = SnackBar(
      content: Text('Email: ${emailCtrl.text}, password: ${passwordCtrl.text}'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
      isLoading.value = true;
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session != null) {
        isLoading.value = false;
        Get.toNamed(AppRoute.home);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  User? get currentUser => _supabase.auth.currentUser;
}
