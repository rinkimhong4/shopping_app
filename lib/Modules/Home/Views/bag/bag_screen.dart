import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shopping_app/Modules/Home/controller/app_theme_controller.dart';
import 'package:shopping_app/Modules/Home/controller/bag_controller.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/widgets/button_navigation_bar.dart';

class BagScreen extends GetView<BagController> {
  BagScreen({super.key});

  final int _selectedIndex = 2;
  final themeController = Get.find<ThemeController>();

  void _onNavItemTapped(int index) {
    if (index != _selectedIndex) {
      switch (index) {
        case 0:
          Get.offNamed(AppRoute.home);
          break;
        case 1:
          Get.offNamed(AppRoute.searchScreen);
          break;
        case 2:
          break;
        case 3:
          Get.offNamed(AppRoute.profile);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildCustomScrollView(context),
      bottomNavigationBar: ButtonNavigationWidget(
        selectedIndex: _selectedIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  CustomScrollView _buildCustomScrollView(BuildContext context) {
    return CustomScrollView(
      slivers: [_buildAppBar(context), _buildBody(context)],
    );
  }

  _buildAppBar(BuildContext context) {
    return SliverAppBar(
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
            Text('Bag', style: Theme.of(context).textTheme.titleLarge),
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
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: LikeButton(
            size: 30,
            circleColor: const CircleColor(
              start: Color(0xff00ddff),
              end: Color(0xff0099cc),
            ),
            bubblesColor: BubblesColor(
              dotPrimaryColor: Theme.of(context).primaryColor,
              dotSecondaryColor: Theme.of(context).cardColor,
            ),
            likeBuilder: (bool isLiked) {
              return Icon(
                Icons.favorite,
                color:
                    isLiked
                        ? Colors.red
                        : Theme.of(context).textTheme.bodySmall?.color
                                ?.withValues(alpha: 0.5) ??
                            Colors.grey,
                size: 28,
              );
            },
          ),
        ),
      ],
    );
  }

  _buildBody(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        spacing: 14,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/b.webp', height: 250),
          Text(
            'Your bag is empty.',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            'Add items to your bag to view them here.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color:
                  Theme.of(context).textTheme.bodySmall?.color ??
                  AppColors.textSecondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24),
            child: ElevatedButton(
              onPressed: () => Get.offNamed(AppRoute.home),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Start Shopping',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
