import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/widgets/button_navigation_bar.dart';

class BagScreen extends StatelessWidget {
  const BagScreen({super.key});

  final int _selectedIndex = 2;
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
      backgroundColor: AppColors.background,
      body: _buildBody(),
      bottomNavigationBar: ButtonNavigationWidget(
        selectedIndex: _selectedIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          expandedHeight: 40,
          flexibleSpace: FlexibleSpaceBar(
            title: Row(
              children: [
                Text('Bag', style: AppTheme.lightTheme.textTheme.titleLarge),
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
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: 78,
                decoration: BoxDecoration(color: Colors.white70),
              ),
            ),
          ),
          floating: false,
          pinned: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 8, right: 8),
              child: LikeButton(
                size: 30,
                circleColor: CircleColor(
                  start: Color(0xff00ddff),
                  end: Color(0xff0099cc),
                ),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: AppColors.primary,
                  dotSecondaryColor: Colors.white,
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 28,
                  );
                },
              ),
            ),
            SizedBox(width: 14),
          ],
        ),
      ],
    );
  }
}
