import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/widgets/button_navigation_bar.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});
  final List<Color> color = [
    Colors.amber,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];
  final List<String> titleListSlider = [
    'Summer Collection',
    'Winter Sale',
    'New Arrivals',
    'Exclusive Offers',
    'Trending Now',
    'Limited Edition',
  ];

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final int _selectedIndex = 1;
  void _onNavItemTapped(int index) {
    if (index != _selectedIndex) {
      switch (index) {
        case 0:
          Get.offNamed(AppRoute.home);
          break;
        case 1:
          // Already on SearchScreen
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                Text('Search', style: AppTheme.lightTheme.textTheme.titleLarge),
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
            background: Container(color: AppColors.accent),
          ),
          floating: false,
          pinned: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/search-outline.svg',
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            ),
            SizedBox(width: 14),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              _buildFeatureBrands,
              _buildHorizontalSlide,
              _searchBanner,
            ],
          ),
        ),
      ],
    );
  }

  get _buildFeatureBrands {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Brands',
                style: AppTheme.lightTheme.textTheme.titleSmall,
              ),
              TextButton(
                onPressed: () {
                  //
                },
                child: Text(
                  'View more',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
          child: SizedBox(
            height: 94,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                final names = [
                  'Zara',
                  'Nike',
                  'Adidas',
                  'Puma',
                  'Gucci',
                  'H&M',
                  'Uniqlo',
                  "Levi's",
                  'Under ',
                  'Reebok',
                ];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            names[index],
                            style: AppTheme.lightTheme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  get _buildHorizontalSlide {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 14, right: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Products 💥',
                style: AppTheme.lightTheme.textTheme.titleSmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 14),
            itemCount: widget.color.length,
            itemBuilder: (context, index) {
              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: 8),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: widget.color[index],
                        // image: DecorationImage(
                        //   image: NetworkImage(
                        //     'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/6f8ced50-ee67-4b21-a330-cebc08c96358/AIR+MAX+DN8.png',
                        //   ),
                        //   fit: BoxFit.cover,
                        // ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.only(top: 165),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              widget.titleListSlider[index],
                              style: AppTheme.lightTheme.textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 8,
                              bottom: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$45.00",
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                                Text(
                                  '\$25.00',
                                  style:
                                      AppTheme.lightTheme.textTheme.bodyMedium,
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
                                    : Colors.grey.withValues(alpha: 0.5),
                            size: 30,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget get _searchBanner {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 14, right: 14),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You'll love these.",
                        style: AppTheme.lightTheme.textTheme.titleLarge
                            ?.copyWith(
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Check out your recommendation.',
                        style: AppTheme.lightTheme.textTheme.labelMedium
                            ?.copyWith(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                        maxLines: 2,
                      ),
                      SizedBox(height: 1),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          minimumSize: const Size(150, 36),
                        ),
                        child: Text(
                          'Shop Now',
                          style: AppTheme.lightTheme.textTheme.bodyLarge
                              ?.copyWith(color: AppColors.accent, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 150,
                  minHeight: 100,
                ),
                child: Image.network(
                  'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/6f8ced50-ee67-4b21-a330-cebc08c96358/AIR+MAX+DN.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
