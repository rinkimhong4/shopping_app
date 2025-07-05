import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/auth_controller.dart';
import 'package:shopping_app/Modules/Home/controller/profile_controller.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProfileController profileController = Get.find<ProfileController>();
  final AuthController authController = Get.find<AuthController>();
  late final TextEditingController currentPasswordCtrl;
  late final TextEditingController newPasswordCtrl;
  late final TextEditingController confirmPasswordCtrl;
  final RxBool _isButtonPressed = false.obs;
  final RxBool _showCurrentPassword = false.obs;
  final RxBool _showNewPassword = false.obs;
  final RxBool _showConfirmPassword = false.obs;

  @override
  void initState() {
    super.initState();
    currentPasswordCtrl = TextEditingController();
    newPasswordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
  }

  @override
  void dispose() {
    currentPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(appBar: _buildAppBar(context), body: _buildBody(context)),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Change Password',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [SizedBox(height: 24), _buildPasswordForm(context)],
      ),
    );
  }

  Widget _buildPasswordForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => _buildPasswordField(
              context,
              label: 'Current Password',
              controller: currentPasswordCtrl,
              obscureText: !_showCurrentPassword.value,
              suffixIcon: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your current password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => _buildPasswordField(
              context,
              label: 'New Password',
              controller: newPasswordCtrl,
              obscureText: !_showNewPassword.value,
              suffixIcon: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a new password';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                if (value == currentPasswordCtrl.text) {
                  return 'New password must be different from current';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => _buildPasswordField(
              context,
              label: 'Confirm New Password',
              controller: confirmPasswordCtrl,
              obscureText: !_showConfirmPassword.value,
              suffixIcon: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your new password';
                }
                if (value != newPasswordCtrl.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 30),
          _buildSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    Widget? suffixIcon,

    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Theme.of(context).dividerColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: AppColors.textPrimary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Colors.red),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Center(
      child: Obx(() {
        return GestureDetector(
          onTapDown: (_) => _isButtonPressed.value = true,
          onTapUp: (_) => _isButtonPressed.value = false,
          onTapCancel: () => _isButtonPressed.value = false,
          onTap:
              profileController.isLoading.value
                  ? null
                  : () async {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      final isCurrentValid = await profileController
                          .verifyCurrentPassword(currentPasswordCtrl.text);

                      if (!isCurrentValid) {
                        Get.snackbar(
                          'Error',
                          'Your password is incorrect',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      try {
                        await profileController.changePassword(
                          currentPassword: currentPasswordCtrl.text,
                          newPassword: newPasswordCtrl.text,
                        );
                        Get.back();
                        Get.snackbar(
                          'Success',
                          'Password changed successfully',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } catch (e) {
                        Get.snackbar(
                          'Error',
                          e.toString(),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                      await _changePassword();
                    }
                  },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 170),
            decoration: BoxDecoration(
              color:
                  _isButtonPressed.value
                      ? Colors.red
                      : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child:
                profileController.isLoading.value
                    ? CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    )
                    : Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
          ),
        );
      }),
    );
  }

  Future<void> _changePassword() async {
    try {
      final success = await profileController.changePassword(
        currentPassword: currentPasswordCtrl.text,
        newPassword: newPasswordCtrl.text,
      );
      if (success) {
        Get.snackbar(
          'Success',
          'Password changed successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }
}
