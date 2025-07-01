import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.imageSlider,
    required this.title,
    required this.subTitle,
  });
  final String? imageSlider, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
              child: Image.asset(
                imageSlider!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          SizedBox(height: 24),
          FadeInRight(
            duration: Duration(milliseconds: 500),
            child: Text(
              title!,
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 8),
          FadeInRight(
            duration: Duration(milliseconds: 600),
            child: Text(
              subTitle!,
              style: AppTheme.lightTheme.textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
