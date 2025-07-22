import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/search_controller.dart';
import 'package:shopping_app/Modules/Home/models/product_model_api.dart';
import 'package:shopping_app/Modules/items/brand_screen.dart';
import 'package:shopping_app/Modules/items/home/items_screen_api.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/widgets/button_navigation_bar.dart';
import 'package:shopping_app/widgets/chip_builder_widget.dart';
import 'package:shopping_app/widgets/slider_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final int _selectedIndex = 1;

  void _onNavItemTapped(int index) {
    if (index != _selectedIndex) {
      switch (index) {
        case 0:
          Get.offNamed(AppRoute.home);
          break;
        case 1:
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: _buildBody(Get.context!),
        bottomNavigationBar: ButtonNavigationWidget(
          selectedIndex: _selectedIndex,
          onTap: _onNavItemTapped,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
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
              titlePadding: const EdgeInsets.only(left: 24, bottom: 18),
              centerTitle: false,
            ),
            floating: false,
            centerTitle: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
        ];
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(context),
          _buildFeaturedBrand(context),
          _buildTrendingProducts(context),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final SearchControllerGetX searchController =
        Get.find<SearchControllerGetX>();
    return GetBuilder<SearchControllerGetX>(
      builder: (controller) {
        return SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: SearchBar(
                hintText: 'Search...',
                controller: controller,
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).cardColor,
                ),
                elevation: WidgetStatePropertyAll(2.0),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.transparent, width: 1),
                  ),
                ),
                textStyle: WidgetStatePropertyAll(
                  TextStyle(fontSize: 16, color: Colors.black87),
                ),
                hintStyle: WidgetStatePropertyAll(
                  TextStyle(
                    fontSize: 16,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                ),
                shadowColor: WidgetStatePropertyAll(
                  Colors.black.withValues(alpha: 0.7),
                ),
                constraints: BoxConstraints(maxHeight: 60),
                onTap: () {
                  controller.openView();
                },
                leading: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                  size: 28,
                ),
                trailing: <Widget>[
                  Center(
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).iconTheme.color!.withValues(alpha: 0.6),
                          width: 1,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.tune,
                          color: Theme.of(context).iconTheme.color,
                          size: 24,
                        ),
                        // ==================
                        onPressed: () {
                          Get.bottomSheet(
                            backgroundColor: Theme.of(context).cardColor,
                            persistent: true,
                            Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                top: 20,
                                left: 20,
                                right: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () => Get.back(),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey.withValues(
                                                  alpha: 0.3,
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                size: 24,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).iconTheme.color,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => Get.back(),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey.withValues(
                                                  alpha: 0.3,
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.check,
                                                size: 24,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).iconTheme.color,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Category',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Divider(),
                                      SliderDiscountWidget(),
                                      SizedBox(height: 4),
                                      SliderPriceRangeWidget(),
                                      SizedBox(height: 5),
                                      Text(
                                        'Brands',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      CustomChipBuilderWidget(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          suggestionsBuilder: (
            BuildContext context,
            SearchController controller,
          ) async {
            final String query = controller.text.toLowerCase();
            final List<TShirtModel> filteredSuggestions =
                searchController.tShirtModels
                    .where(
                      (item) =>
                          item.title != null &&
                          item.title!.toLowerCase().contains(query),
                    )
                    .toList();

            if (searchController.isLoading.value) {
              return [
                ListTile(
                  title: Center(child: CircularProgressIndicator.adaptive()),
                  enabled: false,
                ),
              ];
            }
            if (filteredSuggestions.isEmpty) {
              return [
                ListTile(
                  title: Text(
                    'No results found',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                  enabled: false,
                ),
              ];
            }
            return filteredSuggestions.map((item) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: item.image ?? '',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                    placeholder:
                        (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                    errorWidget:
                        (context, url, error) =>
                            Icon(Icons.error, color: AppColors.primary),
                  ),
                  title: Text(
                    item.title ?? 'Unknown',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${item.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      if (item.rating != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${item.rating!.rate?.toStringAsFixed(1) ?? '0.0'} (${item.rating!.count ?? 0})',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      Text(
                        item.category != null
                            ? categoryValues.reverse[item.category] ?? 'Unknown'
                            : 'Unknown',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(() => DetailScreen(productList: item));
                    // controller.closeView(item.title ?? '');
                  },
                ),
              );
            });
          },
        );
      },
    );
  }

  Widget _buildFeaturedBrand(BuildContext context) {
    List<Map<String, dynamic>> featuredBrands = [
      {'name': 'Nike', 'logo': 'assets/images/Nike-Logo.png'},
      {'name': 'Adidas', 'logo': 'assets/images/adidas.png'},
      {'name': 'Puma', 'logo': 'assets/images/puma.png'},
      {'name': 'Zara', 'logo': 'assets/images/zara.png'},
      {'name': 'Zendo', 'logo': 'assets/images/ZANDO.png'},
      {'name': 'Ten11', 'logo': 'assets/images/ten11.png'},
      {'name': 'Crocodile', 'logo': 'assets/images/CROCODILE.png'},
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Brands',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => BrandScreen());
                  },
                  child: Text(
                    'View all',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: List.generate(
                featuredBrands.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => BrandDetailsPage(
                          brand: '${featuredBrands[index]['name']}',
                          logo: '${featuredBrands[index]['logo']}',
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              featuredBrands[index]['logo'],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          featuredBrands[index]['name'],
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingProducts(BuildContext context) {
    final SearchControllerGetX searchController =
        Get.find<SearchControllerGetX>();

    return Obx(() {
      if (searchController.isLoading.value) {
        return const Expanded(
          child: Center(child: CircularProgressIndicator.adaptive()),
        );
      }
      if (searchController.tShirtModels.isEmpty) {
        return Expanded(
          child: Center(
            child: Text(
              'No products found',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ),
        );
      }
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 34, left: 20, right: 20),
              child: Text(
                'Trending Products',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                itemCount: searchController.tShirtModels.length,
                itemBuilder: (context, index) {
                  final product = searchController.tShirtModels[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailScreen(productList: product));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: product.image ?? '',
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                              errorWidget:
                                  (context, url, error) => Icon(
                                    Icons.error,
                                    color: AppColors.primary,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title ?? 'Unknown',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      product.rating != null
                                          ? '${product.rating!.rate?.toStringAsFixed(1) ?? '0.0'} (${product.rating!.count ?? 0})'
                                          : 'No rating',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.category != null
                                      ? categoryValues.reverse[product
                                              .category] ??
                                          'Unknown'
                                      : 'Unknown',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[500],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
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
    });
  }
}
