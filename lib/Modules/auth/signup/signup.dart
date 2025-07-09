// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/auth_controller.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final controller = Get.find<AuthController>();
  final _formKeySignup = GlobalKey<FormState>();
  bool pwdVisibility = false;
  bool CPwdVisibility = false;
  final ScrollController scrollController = ScrollController();
  bool isScrolled = false;
  String? _serverError; // Store server-side error for email field

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final isScrolledDown = scrollController.offset > 10;
      if (isScrolledDown != isScrolled) {
        setState(() {
          isScrolled = isScrolledDown;
        });
      }
    });
  }

  Color get appBarColor =>
      isScrolled ? AppColors.primary : AppColors.background;
  Color get colorArrowBack => isScrolled ? AppColors.accent : AppColors.primary;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: colorArrowBack),
            onPressed: () {
              controller.emailCtrl.clear();
              controller.passwordCtrl.clear();
              controller.confPasswordCtrl.clear();
              Get.offAndToNamed(AppRoute.login);
            },
          ),
          title:
              isScrolled
                  ? Text(
                    "Sign Up",
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      color: AppColors.accent,
                    ),
                  )
                  : null,
          backgroundColor: appBarColor,
          elevation: isScrolled ? 5 : 0,
          centerTitle: true,
        ),
        backgroundColor: AppColors.background,
        body: _buildBody,
      ),
    );
  }

  Widget get _buildBody {
    List<Map<String, dynamic>> socialMediaLogins = [
      {"icon": Icons.email, "label": "Continue with Email"},
      {"icon": Icons.facebook, "label": "Continue with Facebook"},
    ];
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        width: Get.width,
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please Sign Up",
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Sign up to start shopping and manage your orders.",
                style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 58),
              Form(
                key: _formKeySignup,
                child: Focus(
                  child: Builder(
                    builder: (context) {
                      final hasFocus = Focus.of(context).hasFocus;
                      return Column(
                        children: [
                          // Email TextField
                          TextFormField(
                            autocorrect: false,
                            controller: controller.emailCtrl,
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "Enter your email",
                              hintStyle: AppTheme
                                  .lightTheme
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
                              labelStyle: TextStyle(
                                color:
                                    hasFocus
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                              ),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color:
                                    hasFocus
                                        ? AppColors.primary
                                        : AppColors.textSecondary,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.textPrimary.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.backgroundDark,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              final clientError = controller.validateEmail(
                                value,
                              );
                              if (clientError != null) return clientError;
                              if (_serverError != null) return _serverError;
                              return null;
                            },
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                            ),
                            onChanged: (value) {
                              if (_serverError != null) {
                                setState(() {
                                  _serverError = null;
                                });
                                _formKeySignup.currentState!.validate();
                              }
                            },
                          ),
                          const SizedBox(height: 30),
                          // Password TextField
                          TextFormField(
                            autocorrect: false,
                            controller: controller.passwordCtrl,
                            obscureText: !pwdVisibility,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Password",
                              hintStyle: AppTheme
                                  .lightTheme
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
                              labelStyle: TextStyle(
                                color:
                                    hasFocus
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color:
                                    hasFocus
                                        ? AppColors.primary
                                        : AppColors.textSecondary,
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 14),
                                child: InkWell(
                                  onTap:
                                      () => setState(
                                        () => pwdVisibility = !pwdVisibility,
                                      ),
                                  child: Icon(
                                    pwdVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color:
                                        hasFocus
                                            ? AppColors.primary
                                            : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.textPrimary.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.backgroundDark,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                            validator: controller.validatePassword,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Confirm Password TextField
                          TextFormField(
                            autocorrect: false,
                            controller: controller.confPasswordCtrl,
                            obscureText: !CPwdVisibility,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              hintText: "Confirm Password",
                              hintStyle: AppTheme
                                  .lightTheme
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
                              labelStyle: TextStyle(
                                color:
                                    hasFocus
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color:
                                    hasFocus
                                        ? AppColors.primary
                                        : AppColors.textSecondary,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: InkWell(
                                  onTap:
                                      () => setState(
                                        () => CPwdVisibility = !CPwdVisibility,
                                      ),
                                  child: Icon(
                                    CPwdVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color:
                                        hasFocus
                                            ? AppColors.primary
                                            : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.textPrimary.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.backgroundDark,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              errorStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                            validator: controller.validateConfirmPassword,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 50),
                          // Sign Up Button
                          SizedBox(
                            width: Get.width,
                            height: 58,
                            child: Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  overlayColor: AppColors.accent.withValues(
                                    alpha: 0.1,
                                  ),
                                  foregroundColor:
                                      controller.isLoading.value
                                          ? AppColors.accent.withValues(
                                            alpha: 0.5,
                                          )
                                          : AppColors.accent,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _serverError = null;
                                  });
                                  if (_formKeySignup.currentState!.validate()) {
                                    final error = await controller.signUp(
                                      controller.emailCtrl.text.trim(),
                                      controller.passwordCtrl.text.trim(),
                                    );
                                    if (error != null) {
                                      setState(() {
                                        _serverError = error;
                                      });
                                      _formKeySignup.currentState!.validate();
                                    } else {
                                      controller.emailCtrl.clear();
                                      controller.passwordCtrl.clear();
                                      controller.confPasswordCtrl.clear();
                                    }
                                  }
                                },
                                child:
                                    controller.isLoading.value
                                        ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.accent,
                                          ),
                                        )
                                        : Text(
                                          'Sign Up',
                                          style: AppTheme
                                              .lightTheme
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: AppColors.accent,
                                              ),
                                        ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Divider with "or Login with" text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                  height: 1,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    "or Login with",
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  height: 1,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Social Media Login Buttons
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                socialMediaLogins.map((social) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        overlayColor: AppColors.primary,
                                        minimumSize: const Size(
                                          double.infinity,
                                          54,
                                        ),
                                        elevation: 0,
                                        backgroundColor: AppColors.background,
                                        side: BorderSide(
                                          color: AppColors.primary.withValues(
                                            alpha: 0.6,
                                          ),
                                          width: 1,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            32,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 80,
                                        ),
                                      ),
                                      onPressed: () {
                                        // Handle social login
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            social['icon'],
                                            color: AppColors.primary,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            social['label'],
                                            style: AppTheme
                                                .lightTheme
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: AppColors.primary,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                          const SizedBox(height: 63),
                          // Sign In Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                              const SizedBox(width: 4),
                              TextButton(
                                onPressed: () {
                                  controller.emailCtrl.clear();
                                  controller.passwordCtrl.clear();
                                  controller.confPasswordCtrl.clear();
                                  Get.offAndToNamed(AppRoute.login);
                                },
                                child: Text(
                                  "Sign In",
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: AppColors.primary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
