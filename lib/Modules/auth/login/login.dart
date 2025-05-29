import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/auth/auth_controller.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(AuthController());
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool pwdVisibility = false;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final isScrolledDown = _scrollController.offset > 10;
      if (isScrolledDown != _isScrolled) {
        setState(() {
          _isScrolled = isScrolledDown;
        });
      }
    });
  }

  Color get appBarColor =>
      _isScrolled ? AppColors.primary : AppColors.background;
  @override
  void dispose() {
    _scrollController.dispose();
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
              _isScrolled
                  ? Text(
                    "Sign In",
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      color: AppColors.accent,
                    ),
                  )
                  : null,
          backgroundColor: appBarColor,
          elevation: _isScrolled ? 5 : 0,
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
      controller: _scrollController,
      child: Container(
        width: Get.width,
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please Sign In",
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Login to your account to continue shopping and manage your orders.",
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 58),
              Focus(
                child: Builder(
                  builder: (context) {
                    final hasFocus = Focus.of(context).hasFocus;
                    return Column(
                      children: [
                        // Email TextField
                        TextFormField(
                          controller: emailCtrl,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter your email",
                            hintStyle: AppTheme.lightTheme.textTheme.bodyMedium
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
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                        SizedBox(height: 30),
                        // Password TextField
                        TextFormField(
                          controller: passwordCtrl,
                          obscureText: !pwdVisibility,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter your Password",
                            hintStyle: AppTheme.lightTheme.textTheme.bodyMedium
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
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            suffixIcon: InkWell(
                              onTap:
                                  () => setState(
                                    () => pwdVisibility = !pwdVisibility,
                                  ),
                              child: Icon(
                                pwdVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color:
                                    hasFocus
                                        ? AppColors.primary
                                        : AppColors.textSecondary,
                              ),
                            ),
                          ),
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
                            ),
                            onPressed: () {
                              //
                            },
                            child: Text(
                              'Sign In',
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
                        SizedBox(height: 130),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                            SizedBox(width: 8),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/signup');
                              },
                              child: Text(
                                "Sign Up",
                                style: AppTheme.lightTheme.textTheme.labelSmall
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
            ],
          ),
        ),
      ),
    );
  }
}
