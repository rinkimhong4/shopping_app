import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/AppAssets/app_assets.dart';
import 'package:shopping_app/Modules/Home/controller/auth_controller.dart';
import 'package:shopping_app/Modules/Home/controller/profile_controller.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/widgets/button_navigation_bar.dart';
import 'package:shopping_app/widgets/logout_button.dart';

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
      body: SafeArea(bottom: false, child: _buildCustomScrollView()),
      bottomNavigationBar: ButtonNavigationWidget(
        selectedIndex: _selectedIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  CustomScrollView _buildCustomScrollView() {
    return CustomScrollView(slivers: [_buildAppBar(), _buildBody()]);
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      automaticallyImplyLeading: false,
      expandedHeight: 50,
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
        titlePadding: EdgeInsets.only(left: 24, bottom: 18),
        centerTitle: false,
        background: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(decoration: BoxDecoration(color: Colors.white)),
        ),
      ),
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            AppAssets.chatCircle,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          onPressed: () {
            //
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            AppAssets.bell,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          onPressed: () {},
        ),
        SizedBox(width: 14),
      ],
    );
  }

  Widget _buildBody() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: FutureBuilder<Map<String, dynamic>?>(
          future: profileController.getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data;
            final user = authController.currentUser;
            // Username and email
            final username =
                data?['username'] ?? user?.email?.split('@')[0] ?? 'Guest';
            final email = data?['email'] ?? user?.email ?? 'Guest@gmail.com';
            //========================
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 75,
                              backgroundColor: AppColors.primary,
                              backgroundImage: NetworkImage(
                                'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 20,
                              top: 75,
                              child: GestureDetector(
                                onTap: () {
                                  // Get.toNamed(AppRoute.editProfile);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Username
                              Text(
                                username[0].toUpperCase() +
                                    username.substring(1),
                                style:
                                    AppTheme.lightTheme.textTheme.titleSmall
                                        ?.copyWith(),
                              ),
                              SizedBox(height: 8),
                              // Email
                              Text(
                                email,
                                style: AppTheme.lightTheme.textTheme.labelMedium
                                    ?.copyWith(color: Colors.grey),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // other widgets here
                    _buildCard,
                    _buildGeneralSettings,
                    _buildOtherSettings,
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Profile Card
  // This widget displays a card with user-related actions
  get _buildCard {
    List<Map<String, dynamic>> cardData = [
      {
        'title': 'My Orders',
        'icon': AppAssets.order,
        'color': AppColors.primary,
        'onTap': () => Get.toNamed(AppRoute.myOrders),
      },
      {
        'title': 'Promo Code',
        'icon': AppAssets.discount,
        'color': AppColors.success,
        'onTap': () => Get.toNamed(AppRoute.promoCode),
      },
      {
        'title': 'Shop Now',
        'icon': AppAssets.shop,
        'color': AppColors.error,
        'onTap': () => Get.toNamed(AppRoute.searchScreen),
      },
    ];
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(cardData.length * 2 - 1, (index) {
          if (index.isEven) {
            final cardIndex = index ~/ 2;
            final card = cardData[cardIndex];
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: cardIndex == 0 ? 16 : 8,
                  right: cardIndex == cardData.length - 1 ? 16 : 8,
                ),
                child: GestureDetector(
                  onTap: card['onTap'] as VoidCallback,
                  child: Semantics(
                    label: card['title'] as String,
                    button: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          card['icon'] as String,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            card['color'] as Color? ?? Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          card['title'] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                              ) ??
                              TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container(
              width: 1,
              height: 40,
              color: AppColors.textSecondary.withValues(alpha: 0.2),
            );
          }
        }),
      ),
    );
  }

  // General Settings
  // This widget displays a list of general settings options
  get _buildGeneralSettings {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          'General Settings',
          style: AppTheme.lightTheme.textTheme.titleSmall,
        ),
        SizedBox(height: 14),
        // Divider(),
        ListTile(
          leading: SvgPicture.asset(AppAssets.user, width: 24, height: 24),
          title: Text('My Account'),
          trailing: Icon(Icons.arrow_forward_ios, size: 20),
          onTap: () => Get.toNamed(AppRoute.generalSetting),
        ),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.creditCard,
            width: 24,
            height: 24,
          ),
          title: Text('Payment Methods'),
          trailing: Icon(Icons.arrow_forward_ios, size: 20),
          onTap: () => Get.toNamed(AppRoute.paymentMethods),
        ),
        ListTile(
          leading: SvgPicture.asset(AppAssets.map, width: 24, height: 24),
          title: Text('My Addresses'),
          trailing: Icon(Icons.arrow_forward_ios, size: 20),
          onTap: () => Get.toNamed(AppRoute.myAddress),
        ),
        ListTile(
          leading: SvgPicture.asset(AppAssets.bell, width: 24, height: 24),
          title: Text('Notifications'),
          trailing: Icon(Icons.arrow_forward_ios, size: 20),
          onTap: () => Get.toNamed(AppRoute.myNotification),
        ),
      ],
    );
  }

  // Other Settings
  // This widget displays a list of other settings options
  get _buildOtherSettings {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text('Others', style: AppTheme.lightTheme.textTheme.titleSmall),
        SizedBox(height: 14),
        VerticalDivider(color: Colors.grey, thickness: 1, width: 20),
        ListTile(
          leading: SvgPicture.asset(AppAssets.contact, width: 24, height: 24),
          title: Text('Contact Preferences'),
          trailing: Icon(Icons.arrow_forward_ios, size: 20),
          onTap: () => Get.toNamed(AppRoute.contactPreference),
        ),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.chatCircle,
            width: 24,
            height: 24,
          ),
          title: Text('About Us'),
          trailing: Icon(Icons.arrow_forward_ios, size: 20),
          onTap: () => Get.toNamed(AppRoute.aboutUs),
        ),
        ListTile(
          leading: SvgPicture.asset(AppAssets.info, width: 28, height: 28),
          title: Text('Terms & Conditions'),
          trailing: Icon(Icons.arrow_forward_ios, size: 20),
          onTap: () => Get.toNamed(AppRoute.termCondition),
        ),
        ListTile(
          leading: SvgPicture.asset(AppAssets.support, width: 24, height: 24),
          title: Text('Customer Support'),
          trailing: Icon(Icons.arrow_forward_ios, size: 20),
          onTap: () => Get.toNamed(AppRoute.customerSupport),
        ),
        SizedBox(height: 24),
        LogOutButton(
          text: "Sign Out",
          onPressed: () => authController.signOut(),
        ),
      ],
    );
  }
}
