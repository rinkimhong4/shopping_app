import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/Views/Start_Screen/onboard_content.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentSlideImage = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    currentSlideImage < onBoardScreenData.length - 1
        ? _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
        : Get.offNamed(AppRoute.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.background, body: _buildBody);
  }

  get _buildBody {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 20,
            child: PageView.builder(
              controller: _pageController,
              itemCount: onBoardScreenData.length,
              onPageChanged: (value) {
                setState(() {
                  currentSlideImage = value;
                });
              },
              itemBuilder:
                  (context, index) => OnboardContent(
                    imageSlider: onBoardScreenData[index]["imageSlider"],
                    title: onBoardScreenData[index]["title"],
                    subTitle: onBoardScreenData[index]["subTitle"],
                  ),
            ),
          ),
          SizedBox(height: 14),
          DotsIndicator(
            dotsCount: onBoardScreenData.length,
            position: currentSlideImage.toDouble(),
            decorator: DotsDecorator(
              activeColor: const Color(0xFF22A45D),
              color: Colors.grey.withValues(alpha: 0.5),
              size: Size.square(9),
              activeSize: Size(19, 9),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              onPressed: _goToNextPage,
              style: AppTheme.lightTheme.elevatedButtonTheme.style!.copyWith(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              child: Text(
                (currentSlideImage == onBoardScreenData.length - 1
                        ? "Get Started"
                        : "Next")
                    .toUpperCase(),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> onBoardScreenData = [
  {
    "imageSlider": "assets/images/image1.avif",
    "title": "Discover the Latest Trends",
    "subTitle":
        "Shop the newest arrivals and stay stylish\nwith our exclusive clothing collection.",
  },
  {
    "imageSlider": "assets/images/image2.avif",
    "title": "Exclusive Offers",
    "subTitle":
        "Enjoy special discounts and free shipping\non your favorite fashion items.",
  },
  {
    "imageSlider": "assets/images/image3.avif",
    "title": "Find Your Style",
    "subTitle":
        "Browse a wide range of clothing and accessories\nto match your unique taste.",
  },
];
