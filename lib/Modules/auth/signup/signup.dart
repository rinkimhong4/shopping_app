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
  // final controller = Get.put(AuthController());
  final controller = Get.find<AuthController>();
  final _formKeySignup = GlobalKey<FormState>();
  bool pwdVisibility = false;
  final ScrollController scrollController = ScrollController();
  bool isScrolled = false;

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
              Get.toNamed(AppRoute.login);
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
        body: Container(child: _buildBody),
      ),
    );
  }

  get _buildBody {
    List<Map<String, dynamic>> socialMediaLogins = [
      // {"icon": Icons.apple, "label": "Continue with Apple"},
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
              SizedBox(height: 8),
              Text(
                "Sign up to start shopping and manage your orders.",
                style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 58),
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
                                  color: AppColors.primary,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),

                            validator: controller.validateEmail,
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          SizedBox(height: 30),
                          // Password TextField
                          TextFormField(
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
                                  color: AppColors.primary,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            validator: controller.validatePassword,
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          SizedBox(height: 30),
                          // Confirm Password TextField
                          TextFormField(
                            controller: controller.confPasswordCtrl,
                            obscureText: !pwdVisibility,
                            decoration: InputDecoration(
                              labelText: "Password",
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
                                  color: AppColors.primary,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            validator: controller.validateConfirmPassword,
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          SizedBox(height: 8),
                          // TextButton for Forgot Password
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
                          SizedBox(height: 24),
                          // Sign In Button
                          SizedBox(
                            width: Get.width,
                            height: 58,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                overlayColor: AppColors.accent.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                              onPressed: () async {
                                if (_formKeySignup.currentState!.validate()) {
                                  await controller.signUp(
                                    controller.emailCtrl.text.trim(),
                                    controller.passwordCtrl.text.trim(),
                                  );
                                } else {
                                  debugPrint("Form is not valid");
                                }
                              },
                              // onPressed:
                              //     () => controller.submitCommand(context),
                              child: Text(
                                'Sign Up',
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.accent),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
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
                          SizedBox(height: 24),

                          // Social Media Login Buttons
                          Column(
                            spacing: 24,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                socialMediaLogins.map((social) {
                                  return ElevatedButton(
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
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 80,
                                      ),
                                    ),
                                    onPressed: () {
                                      //
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          social['icon'],
                                          color: AppColors.primary,
                                          size: 24,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          social['label'],
                                          style: AppTheme
                                              .lightTheme
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: AppColors.primary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                          SizedBox(height: 65),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                              SizedBox(width: 4),
                              TextButton(
                                onPressed: () {
                                  controller.emailCtrl.clear();
                                  controller.passwordCtrl.clear();
                                  controller.confPasswordCtrl.clear();
                                  Get.toNamed(AppRoute.login);
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
