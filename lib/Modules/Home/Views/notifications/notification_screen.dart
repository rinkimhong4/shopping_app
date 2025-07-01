import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/Modules/AppAssets/app_assets.dart';
import 'package:shopping_app/Modules/Home/controller/home_controller.dart';
import 'package:shopping_app/Modules/items/home/items_screen_api.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/Modules/Home/controller/app_theme_controller.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  final ScrollController _scrollController = ScrollController();
  final themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<HomeController>();
      controller.isLoading.value = true;
      Future.delayed(Duration(milliseconds: 600), () {
        controller.isLoading.value = false;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    try {
      final controller = Get.find<HomeController>();
      controller.isLoading.value = true;
      await controller.fetchTShirts();
      controller.isLoading.value = false;
    } catch (e) {
      debugPrint('Refresh error: $e');
      Get.snackbar('Error', 'Failed to refresh notifications');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            'Notifications',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
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
            SizedBox(width: 24),
          ],
        ),
        body: LiquidPullToRefresh(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          showChildOpacityTransition: false,
          springAnimationDurationInMilliseconds: 200,
          height: 40,
          color: Theme.of(context).primaryColor,
          child:
              controller.isLoading.value
                  ? _buildShimmerLoading(context)
                  : controller.tShirtModels.isEmpty
                  ? Center(
                    child: Text(
                      'No notifications available',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  )
                  : ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: controller.tShirtModels.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final item = controller.tShirtModels[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {},
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              icon: Icons.share_outlined,
                              label: 'Share',
                            ),
                          ],
                        ),
                        key: ValueKey(item.id),
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          dismissible: DismissiblePane(
                            onDismissed: () {
                              controller.tShirtModels.removeAt(index);
                            },
                          ),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                controller.tShirtModels.removeAt(index);
                              },
                              backgroundColor: AppColors.error,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.to(() => DetailScreen(productList: item));
                          },
                          key: Key(item.id.toString()),
                          minVerticalPadding: 10,
                          isThreeLine: true,
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 40,
                            child: CachedNetworkImage(
                              imageUrl: item.image ?? '',
                              placeholder:
                                  (context, url) =>
                                      CircularProgressIndicator.adaptive(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Theme.of(context).primaryColor,
                                            ),
                                      ),
                              errorWidget:
                                  (context, url, error) =>
                                      Icon(Icons.error, color: AppColors.error),
                            ),
                          ),
                          title: Text(
                            item.title ?? 'No Name',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.color,
                                ),
                          ),
                          horizontalTitleGap: 14,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          subtitle: Text(
                            item.description ?? 'No description',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            '\$${item.price?.toStringAsFixed(2) ?? '0.00'}',
                            style: AppTheme.lightTheme.textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: 6,
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Theme.of(context).hoverColor,
          highlightColor: Theme.of(context).highlightColor,
          child: ListTile(
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            title: Container(
              width: double.infinity,
              height: 15,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Container(
                  width: 200,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 120,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
