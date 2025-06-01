import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shopping_app/Modules/Home/controller/home_controller.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/widgets/timer.dart';

class HomeScreen extends StatefulWidget {
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

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.startAutoSlide(widget.color.length);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.background, body: _buildBody());
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 40,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'HypeWear!',
              style: AppTheme.lightTheme.textTheme.titleMedium,
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

  Widget get _bannerSlider {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: PageView.builder(
              controller:
                  _controller.pageController, // Use controller's PageController
              itemCount: widget.color.length,
              onPageChanged: (index) {
                _controller.updateCurrentPage(index); // Update current page
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(color: widget.color[index]),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 110),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.titleListSlider[index],
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
          const SizedBox(height: 12),
          DotsIndicator(
            dotsCount: widget.color.length,
            position: _controller.currentPage.toDouble(),
            decorator: DotsDecorator(
              activeColor: widget.color[_controller.currentPage.round()],
              size: const Size.square(5),
              activeSize: const Size(10, 8),
            ),
          ),
        ],
      ),
    );
  }

  get _buildHorizontalSlide {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 14, right: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Selling Fast 🔥',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              CustomTimePicker(),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 8),
            itemCount: widget.color.length,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 8),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: widget.color[index],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.titleListSlider[index],
                            style: AppTheme.lightTheme.textTheme.bodyLarge,
                            textAlign: TextAlign.center,
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

  get _buildVerticalTitle {
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
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            decoration: BoxDecoration(
              color: widget.color[index],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.titleListSlider[index],
                      style: AppTheme.lightTheme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
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
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                          Text(
                            '\$25.00',
                            style: AppTheme.lightTheme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
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
        }, childCount: widget.color.length),
      ),
    );
  }
}
