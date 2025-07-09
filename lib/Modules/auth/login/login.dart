import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/auth_controller.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.find<AuthController>();
  final _formKeyLogin = GlobalKey<FormState>();
  bool pwdVisibility = false;
  bool isScrolled = false;
  String? _serverError;
  final ScrollController scrollController = ScrollController();

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
          title:
              isScrolled
                  ? Text(
                    "Sign In",
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
                "Welcome Back!",
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Login to your account to continue shopping and manage your orders.",
                style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 58),
              Form(
                key: _formKeyLogin,
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
                                        ? AppColors.textPrimary
                                        : AppColors.textSecondary,
                              ),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color:
                                    hasFocus
                                        ? AppColors.textPrimary
                                        : AppColors.textSecondary,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide(
                                  color: AppColors.textPrimary.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            validator: controller.validateEmail,
                            style: TextStyle(color: AppColors.textPrimary),
                            onChanged: (value) {
                              if (_serverError != null) {
                                setState(() {
                                  _serverError = null;
                                });
                                _formKeyLogin.currentState!.validate();
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
                              hintText: "Enter your Password",
                              hintStyle: AppTheme
                                  .lightTheme
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
                              labelStyle: TextStyle(
                                color:
                                    hasFocus
                                        ? AppColors.textPrimary
                                        : AppColors.textSecondary,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color:
                                    hasFocus
                                        ? AppColors.textPrimary
                                        : AppColors.textSecondary,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide(
                                  color: AppColors.textPrimary.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 14),
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
                            ),
                            validator: (value) {
                              final clientError = controller.validatePassword(
                                value,
                              );
                              if (clientError != null) return clientError;
                              if (_serverError != null) return _serverError;
                              return null;
                            },
                            style: TextStyle(color: AppColors.textPrimary),
                            onChanged: (value) {
                              if (_serverError != null) {
                                setState(() {
                                  _serverError = null;
                                });
                                _formKeyLogin.currentState!.validate();
                              }
                            },
                          ),
                          const SizedBox(height: 8),
                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Navigate to Forgot Password Screen
                              },
                              child: Text(
                                "Forgot Password?",
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(color: AppColors.primary),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Sign In Button
                          SizedBox(
                            width: Get.width,
                            height: 52,
                            child: Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  overlayColor: AppColors.accent.withValues(
                                    alpha: 0.1,
                                  ),
                                  elevation: 0,
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
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
                                  if (_formKeyLogin.currentState!.validate()) {
                                    final error = await controller.signIn(
                                      controller.emailCtrl.text.trim(),
                                      controller.passwordCtrl.text,
                                    );
                                    if (error != null) {
                                      setState(() {
                                        _serverError = error;
                                      });
                                      _formKeyLogin.currentState!.validate();
                                    } else {
                                      controller.emailCtrl.clear();
                                      controller.passwordCtrl.clear();
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
                                          'Sign In',
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
                                        minimumSize: Size(double.infinity, 54),
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
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              social['label'],
                                              style: AppTheme
                                                  .lightTheme
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: AppColors.primary,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                          // Sign Up
                          const SizedBox(height: 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () {
                                  controller.emailCtrl.clear();
                                  controller.passwordCtrl.clear();
                                  Get.offAndToNamed(AppRoute.signup);
                                },
                                child: Text(
                                  "Sign Up",
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
