import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/Views/Start_Screen/onboard_content.dart';
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
          duration: Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        )
        : Get.offNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.background, body: _buildBody);
  }

  get _buildBody {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                activeColor: Color(0xFF22A45D),
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
              padding: EdgeInsets.symmetric(horizontal: 24),
              child:
                  currentSlideImage == onBoardScreenData.length - 1
                      ? ElevatedButton(
                        onPressed: _goToNextPage,
                        style: AppTheme.lightTheme.elevatedButtonTheme.style!,
                        child: Text("Get Started".toUpperCase()),
                      )
                      : ElevatedButton(
                        onPressed: _goToNextPage,
                        style: AppTheme.lightTheme.elevatedButtonTheme.style!,
                        child: Text("Next".toUpperCase()),
                      ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> onBoardScreenData = [
  {
    "imageSlider":
        "https://images.unsplash.com/photo-1529139574466-a303027c1d8b?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "title": "Discover the Latest Trends",
    "subTitle":
        "Shop the newest arrivals and stay stylish\nwith our exclusive clothing collection.",
  },
  {
    "imageSlider":
        "https://plus.unsplash.com/premium_photo-1708110920881-635419c3411f?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "title": "Exclusive Offers",
    "subTitle":
        "Enjoy special discounts and free shipping\non your favorite fashion items.",
  },
  {
    "imageSlider":
        "https://images.unsplash.com/photo-1601762603339-fd61e28b698a?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "title": "Find Your Style",
    "subTitle":
        "Browse a wide range of clothing and accessories\nto match your unique taste.",
  },
];
