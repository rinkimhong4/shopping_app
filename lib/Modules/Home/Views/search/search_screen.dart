import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/AppAssets/app_assets.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/widgets/button_navigation_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  final int _selectedIndex = 1;

  void _onNavItemTapped(int index) {
    if (index != _selectedIndex) {
      switch (index) {
        case 0:
          Get.offNamed(AppRoute.home);
          break;
        case 1:
          // Already on Search Screen, do nothing
          break;
        case 2:
          Get.offNamed(AppRoute.bagScreen);
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
      body: _buildBody(Get.context!),
      bottomNavigationBar: ButtonNavigationWidget(
        selectedIndex: _selectedIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
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
                Text('Search', style: Theme.of(context).textTheme.titleLarge),
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
          ),
          floating: false,
          pinned: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                AppAssets.searchOutline,
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
        ),
      ],
    );
  }
}
