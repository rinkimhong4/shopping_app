import 'package:cached_network_image/cached_network_image.dart';
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
            child: CachedNetworkImage(
              imageUrl: imageSlider!,
              fit: BoxFit.cover,
              imageBuilder:
                  (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            ),
          ),
          SizedBox(height: 24),
          Text(title!, style: AppTheme.lightTheme.textTheme.titleLarge),
          SizedBox(height: 8),
          Text(
            subTitle!,
            style: AppTheme.lightTheme.textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
        ],
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
