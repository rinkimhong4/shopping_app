import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/Modules/Home/Views/Start_Screen/onboard_content.dart';
import 'package:shopping_app/Modules/Home/Views/home_screen.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentSlide = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    currentSlide < onBoardScreenData.length - 1
        ? _pageController.nextPage(
          duration: Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        )
        : Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
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
            Spacer(flex: 2),
            Expanded(
              flex: 14,
              child: PageView.builder(
                controller: _pageController,
                itemCount: onBoardScreenData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentSlide = value;
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
              position: currentSlide.toDouble(),
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:
                  currentSlide == onBoardScreenData.length - 1
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
