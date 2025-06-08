import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shopping_app/Modules/items/items_screen_api.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/core/data/home_data.dart';
import 'package:shopping_app/widgets/button_navigation_bar.dart';
import 'package:shopping_app/widgets/timer.dart';
import 'package:shopping_app/Modules/Home/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  final int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Get.offAndToNamed(AppRoute.searchScreen);
        break;
      case 2:
        Get.offAndToNamed(AppRoute.bagScreen);
        break;
      case 3:
        Get.offAndToNamed(AppRoute.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startAutoSlide(HomeDataSlider.bannerItems.length);
    });

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
            title: Text(
              'HypeWear!',
              style: AppTheme.lightTheme.textTheme.titleLarge,
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
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/chat-circle-dots.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/icons-bell.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
            SizedBox(width: 14),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _bannerSlider,
            _buildHorizontalSlide,
          ]),
        ),
        _buildVerticalTitle,
        _popularProductsGrid,
      ],
    );
  }

  get _bannerSlider {
    final controller = Get.find<HomeController>();
    final bannerItems = HomeDataSlider.bannerItems;
    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 230,
            width: double.infinity,
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: bannerItems.length,
              onPageChanged: (index) {
                controller.updateCurrentPage(index);
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        bannerItems[index]['image']!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 110),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            bannerItems[index]['title']!,
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              side: BorderSide(
                                color: AppColors.accent,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 60),
                            ),
                            onPressed: () {
                              //
                            },
                            child: Text(
                              'Shop Now',
                              style: AppTheme.lightTheme.textTheme.titleSmall
                                  ?.copyWith(color: AppColors.accent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 12),
          DotsIndicator(
            dotsCount: bannerItems.length,
            position: controller.currentPage.toDouble(),
            decorator: DotsDecorator(
              size: Size.square(5),
              activeSize: Size(10, 8),
              activeColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  get _buildHorizontalSlide {
    final controller = Get.find<HomeController>();
    return Obx(
      () =>
          controller.isLoading.value
              ? Center(child: CircularProgressIndicator.adaptive())
              : controller.tShirtModels.isEmpty
              ? Center(child: Text('No found'))
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 14, right: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Text(
                            'Selling Fast 🔥',
                            style: AppTheme.lightTheme.textTheme.titleMedium,
                          ),
                        ),
                        const CustomTimePicker(),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 14),
                      itemCount: controller.tShirtModels.length,
                      itemBuilder: (context, index) {
                        final tShirt = controller.tShirtModels[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => DetailScreen(productList: tShirt));
                          },
                          child: Container(
                            width: 160,
                            margin: const EdgeInsets.only(right: 14),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        tShirt.image ?? '',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.only(top: 140),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),

                                          child: Text(
                                            tShirt.title ?? 'No Title',
                                            style:
                                                AppTheme
                                                    .lightTheme
                                                    .textTheme
                                                    .bodyLarge,
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                '\$${(tShirt.price != null ? tShirt.price! * 0.55 : 0).toStringAsFixed(2)}',
                                                style: AppTheme
                                                    .lightTheme
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                      color: AppColors.primary,
                                                    ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "\$${tShirt.price?.toStringAsFixed(2) ?? ''}",
                                                style: AppTheme
                                                    .lightTheme
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      decoration:
                                                          TextDecoration
                                                              .lineThrough,
                                                      color: AppColors.error,
                                                    ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: LikeButton(
                                    size: 30,
                                    circleColor: const CircleColor(
                                      start: Color(0xff00ddff),
                                      end: Color(0xff0099cc),
                                    ),
                                    bubblesColor: const BubblesColor(
                                      dotPrimaryColor: Colors.pink,
                                      dotSecondaryColor: Colors.white,
                                    ),
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        Icons.favorite,
                                        color:
                                            isLiked
                                                ? Colors.red
                                                : Colors.grey.withValues(
                                                  alpha: 0.5,
                                                ),
                                        size: 30,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }

  Widget get _buildVerticalTitle {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          const SizedBox(height: 24),
          Text(
            'Popular Products',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }

  SliverPadding get _popularProductsGrid {
    final bodyItems =
        HomeDataSlider.bodyItems['products'] as Set<Map<String, dynamic>>;
    final productsList = bodyItems.toList();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final item = productsList[index];
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(item['image'] ?? ''),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 24,
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(
                          item['title'] != null && item['title']!.length > 20
                              ? '${item['title']!.substring(0, 17)}...'
                              : item['title'] ?? '',
                          style: AppTheme.lightTheme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 14,
                                right: 4,
                              ),
                              child: Text(
                                item['price'] ?? '',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(color: AppColors.primary),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 14),
                              child: Text(
                                item['discount'] ?? '',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: AppColors.error,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: LikeButton(
                    size: 30,
                    circleColor: CircleColor(
                      start: Color(0xff00ddff),
                      end: Color(0xff0099cc),
                    ),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Colors.pink,
                      dotSecondaryColor: Colors.white,
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color:
                            isLiked
                                ? Colors.red
                                : Colors.grey.withValues(alpha: 0.5),
                        size: 30,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }, childCount: productsList.length),
      ),
    );
  }
}
