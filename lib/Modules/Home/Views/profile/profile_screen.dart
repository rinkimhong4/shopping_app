import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/AppAssets/app_assets.dart';
import 'package:shopping_app/Modules/Home/controller/app_theme_controller.dart';
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
  final themeController = Get.find<ThemeController>();

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: _buildCustomScrollView()),
      bottomNavigationBar: ButtonNavigationWidget(
        selectedIndex: _selectedIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  CustomScrollView _buildCustomScrollView() {
    return CustomScrollView(slivers: [_buildAppBar(), _buildBody]);
  }

  _buildAppBar() => SliverAppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness:
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
    ),
    automaticallyImplyLeading: false,
    expandedHeight: 40,
    flexibleSpace: FlexibleSpaceBar(
      title: Row(
        children: [
          Text('Profile', style: Theme.of(context).textTheme.titleLarge),
          Text(
            '.',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      titlePadding: EdgeInsets.only(left: 24, bottom: 18),
      centerTitle: false,
    ),
    // floating: false,
    // pinned: true,
    elevation: 0,
    actions: [
      IconButton(
        icon: SvgPicture.asset(
          AppAssets.chatCircle,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color ?? Colors.black,
            BlendMode.srcIn,
          ),
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
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        onPressed: () {},
      ),
      SizedBox(width: 14),
    ],
  );

  get _buildBody => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader,
            SizedBox(height: 20),
            _buildCard,
            _buildGeneralSettings,
            _buildOtherSettings,
          ],
        );
      }),
    ),
  );

  get _buildProfileHeader {
    final user = authController.currentUser;
    final username =
        profileController.username.value.isNotEmpty
            ? profileController.username.value
            : (user?.email?.split('@')[0] ?? 'Guest');

    final email =
        profileController.email.value.isNotEmpty
            ? profileController.email.value
            : (user?.email ?? 'guest@gmail.com');

    final imagePath = profileController.profileImageUrl.value;
    final isNetwork = imagePath.startsWith('http');

    Widget profileImageWidget;

    if (profileController.isLoading.value) {
      profileImageWidget = CircleAvatar(
        radius: 56,
        backgroundColor: Theme.of(context).cardColor,
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (imagePath.isNotEmpty) {
      if (isNetwork) {
        profileImageWidget = CircleAvatar(
          radius: 56,
          backgroundColor: Theme.of(context).cardColor,
          backgroundImage: NetworkImage(imagePath),
          onBackgroundImageError: (_, __) => debugPrint("Network image error"),
        );
      } else {
        final file = File(imagePath);
        profileImageWidget =
            file.existsSync()
                ? CircleAvatar(
                  radius: 56,
                  backgroundColor: Theme.of(context).cardColor,
                  backgroundImage: FileImage(file),
                )
                : CircleAvatar(
                  radius: 56,
                  backgroundColor: Theme.of(context).cardColor,
                  child: Icon(
                    Icons.person,
                    size: 56,
                    color: Theme.of(context).hintColor,
                  ),
                );
      }
    } else {
      profileImageWidget = CircleAvatar(
        radius: 56,
        backgroundColor: Theme.of(context).cardColor,
        child: Icon(Icons.person, size: 56, color: Theme.of(context).hintColor),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            profileImageWidget,
            Positioned(
              bottom: 0,
              right: 0,
              top: 75,
              child: GestureDetector(
                onTap: () async {
                  final userId = authController.currentUser?.id;
                  if (userId != null) {
                    await profileController.uploadProfileImage(userId);
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please log in to upload an image.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.edit, color: Colors.white, size: 18),
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
              Text(
                username[0].toUpperCase() + username.substring(1),
                style:
                    Theme.of(context).textTheme.titleSmall?.copyWith(
                      color:
                          Theme.of(context).textTheme.titleSmall?.color ??
                          Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ) ??
                    TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.white,
                    ),
              ),
              SizedBox(height: 8),
              Text(
                email,
                style:
                    Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).hintColor,
                    ) ??
                    TextStyle(fontSize: 14, color: Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  get _buildCard {
    List<Map<String, dynamic>> cardData = [
      {
        'title': 'My Orders',
        'icon': AppAssets.order,
        'color': Theme.of(context).primaryColor,
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
        'onTap': () => Get.offAndToNamed(AppRoute.searchScreen),
      },
    ];
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
                            card['color'] as Color? ??
                                Theme.of(context).iconTheme.color ??
                                Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          card['title'] as String,
                          style:
                              Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(fontSize: 12) ??
                              TextStyle(
                                fontSize: 12,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                              ),
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
              color: Theme.of(context).dividerColor,
            );
          }
        }),
      ),
    );
  }

  get _buildGeneralSettings {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text('General Settings', style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 14),
        Obx(
          () => ListTile(
            leading: Icon(
              themeController.isDarkMode.value
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text('Theme', style: Theme.of(context).textTheme.bodyMedium),
            trailing: Switch.adaptive(
              value: themeController.isDarkMode.value,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (bool value) {
                themeController.toggleTheme();
              },
            ),
          ),
        ),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.user,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.black,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            'My Account',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () => Get.toNamed(AppRoute.generalSetting),
        ),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.creditCard,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.black,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            'Payment Methods',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () => Get.toNamed(AppRoute.paymentMethods),
        ),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.map,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.black,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            'My Addresses',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () => Get.toNamed(AppRoute.myAddress),
        ),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.bell,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.black,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            'Notifications',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () => Get.toNamed(AppRoute.myNotification),
        ),
      ],
    );
  }

  get _buildOtherSettings {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text('Others', style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 14),
        VerticalDivider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
          width: 20,
        ),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.contact,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.black,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            'Contact Preferences',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () => Get.toNamed(AppRoute.contactPreference),
        ),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.chatCircle,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.black,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            'About Us',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () => Get.toNamed(AppRoute.aboutUs),
        ),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.info,
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.black,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            'Terms & Conditions',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () => Get.toNamed(AppRoute.termCondition),
        ),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.support,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.black,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            'Customer Support',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
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
