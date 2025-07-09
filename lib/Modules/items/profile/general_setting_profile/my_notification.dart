import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/configs/AppAssets/app_assets.dart';
import 'package:shopping_app/Modules/Home/controller/app_theme_controller.dart';
import 'package:shopping_app/Modules/Home/controller/home_controller.dart';
import 'package:shopping_app/Modules/items/home/items_screen_api.dart';

class MyNotificationItems extends StatefulWidget {
  const MyNotificationItems({super.key});

  @override
  State<MyNotificationItems> createState() => _MyNotificationItemsState();
}

//  same of AppBar
class _MyNotificationItemsState extends State<MyNotificationItems> {
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
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
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
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                  : ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: controller.tShirtModels.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final item = controller.tShirtModels[index];
                      return ListTile(
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor,
                                      ),
                                    ),
                            errorWidget:
                                (context, url, error) => Icon(
                                  Icons.error,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                        ),
                        title: Text(
                          item.title ?? 'No Name',
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyLarge,
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
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              builder:
                                  (context) => Padding(
                                    padding: EdgeInsets.only(
                                      top: 14,
                                      left: 14,
                                      right: 14,
                                      bottom: 24,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 72,
                                              width: 72,
                                              decoration: BoxDecoration(
                                                image:
                                                    (item.image != null &&
                                                            item
                                                                .image!
                                                                .isNotEmpty)
                                                        ? DecorationImage(
                                                          image:
                                                              CachedNetworkImageProvider(
                                                                item.image!,
                                                              ),
                                                          fit: BoxFit.cover,
                                                        )
                                                        : null,
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color
                                                    ?.withValues(alpha: 0.1),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              item.title ?? '',
                                              textAlign: TextAlign.center,
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                            ),
                                            SizedBox(height: 14),
                                          ],
                                        ),
                                        ListTile(
                                          leading: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color
                                                  ?.withValues(alpha: 0.1),
                                            ),
                                            child: Icon(
                                              Icons.remove_from_queue,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).iconTheme.color,
                                              size: 24,
                                            ),
                                          ),
                                          title: Text(
                                            'Delete this notification',
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleSmall,
                                          ),
                                          onTap: () {
                                            controller.tShirtModels.removeAt(
                                              index,
                                            );
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color
                                                  ?.withValues(alpha: 0.1),
                                            ),
                                            child: Icon(
                                              Icons.share_outlined,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).iconTheme.color,
                                              size: 24,
                                            ),
                                          ),
                                          title: Text(
                                            'Share',
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleSmall,
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                            // Placeholder for share action
                                          },
                                        ),
                                        ListTile(
                                          leading: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color
                                                  ?.withValues(alpha: 0.1),
                                            ),
                                            child: Icon(
                                              Icons.add_shopping_cart,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).iconTheme.color,
                                              size: 20,
                                            ),
                                          ),
                                          title: Text(
                                            'Add to cart',
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleSmall,
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                            // Placeholder for add to cart action
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                            );
                          },
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
      itemCount: 10,
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          direction: ShimmerDirection.rtl,
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
