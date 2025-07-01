import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shopping_app/Modules/AppAssets/app_assets.dart';
import 'package:shopping_app/Modules/Home/models/product_model_fake_api.dart';
import 'package:shopping_app/Modules/items/home/items_screen_non_api.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/core/data/home_data.dart' show HomeDataSlider;
import 'package:shopping_app/Modules/Home/controller/app_theme_controller.dart';

class BellScreenNewRelease extends StatefulWidget {
  const BellScreenNewRelease({super.key});

  @override
  _BellScreenNewReleaseState createState() => _BellScreenNewReleaseState();
}

class _BellScreenNewReleaseState extends State<BellScreenNewRelease> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final themeController = Get.find<ThemeController>();

  Set<Map<String, dynamic>> bodyItems =
      HomeDataSlider.bodyItems['products'] as Set<Map<String, dynamic>>;
  late List<Map<String, dynamic>> productsList;

  @override
  void initState() {
    super.initState();
    productsList = bodyItems.toList();
  }

  Future<void> _handleRefresh() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        productsList = bodyItems.toList()..shuffle();
      });
    } catch (e) {
      debugPrint('Refresh error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'New releases',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
          const SizedBox(width: 24),
        ],
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: LiquidPullToRefresh(
            key: _refreshIndicatorKey,
            onRefresh: _handleRefresh,
            showChildOpacityTransition: false,
            springAnimationDurationInMilliseconds: 200,
            height: 40,
            color: Theme.of(context).primaryColor,
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(8),
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                final item = productsList[index];
                final imageUrl = item['image'].toString();
                return _buildImageCard(context, imageUrl, index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(BuildContext context, String imageUrl, int index) {
    final heights = [200.0, 250.0, 300.0, 180.0, 220.0];
    final randomHeight = heights[index % heights.length];

    return GestureDetector(
      onTap: () {
        Get.to(
          () => DetainScreenNonAPI(
            product: Product.fromJson(productsList[index]),
          ),
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Theme.of(context).cardColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: randomHeight,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => Container(
                    color: Theme.of(context).hoverColor,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        // color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
              errorWidget:
                  (context, url, error) => Container(
                    color: Theme.of(context).hoverColor,
                    child: Icon(Icons.error, color: AppColors.error),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
