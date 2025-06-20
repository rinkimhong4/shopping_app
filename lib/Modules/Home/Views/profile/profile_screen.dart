import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/auth_controller.dart';
import 'package:shopping_app/Modules/Home/controller/profile_controller.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/widgets/button_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _selectedIndex = 3;
  final authController = Get.find<AuthController>();
  final profileController = Get.find<ProfileController>();

  void _onNavItemTapped(int index) {
    if (index != _selectedIndex) {
      switch (index) {
        case 0:
          Get.offAndToNamed(AppRoute.home);
          break;
        case 1:
          Get.offAndToNamed(AppRoute.searchScreen);
          break;
        case 2:
          Get.offAndToNamed(AppRoute.bagScreen);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildCustomScrollView(),
      bottomNavigationBar: ButtonNavigationWidget(
        selectedIndex: _selectedIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  CustomScrollView _buildCustomScrollView() {
    return CustomScrollView(slivers: [_buildAppBar(), _buildBody()]);
  }

  _buildAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 40,
      flexibleSpace: FlexibleSpaceBar(
        title: Row(
          children: [
            Text('Profile', style: AppTheme.lightTheme.textTheme.titleLarge),
            Text(
              '.',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 24, bottom: 18),
        centerTitle: false,
        background: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
        ),
      ),
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/icons/chat-circle-dots.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            'assets/icons/icons-bell.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 14),
      ],
    );
  }

  _buildBody() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: FutureBuilder<Map<String, dynamic>?>(
          future: profileController.getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 56,
                      backgroundColor: AppColors.primary,
                      backgroundImage: const NetworkImage(
                        'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data == null ? '' : data['username'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              authController.signOut();
                            },
                            child: Icon(Icons.logout),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
