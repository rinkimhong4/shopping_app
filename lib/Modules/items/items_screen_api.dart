import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shopping_app/Modules/Home/Views/filter_screen.dart';
import 'package:shopping_app/Modules/Home/models/product_model.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class DetailScreen extends StatelessWidget {
  final TShirtModel productList;

  const DetailScreen({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    final double originalPrice = productList.price ?? 0.0;
    final double discount = originalPrice * 0.45;
    final double discountedPrice = originalPrice - discount;
    final double discountPercentage =
        originalPrice != 0 ? (discount / originalPrice) * 100 : 0;

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.accent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            _buildProductDetails(
              context,
              originalPrice,
              discountedPrice,
              discountPercentage,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.accent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 14, top: 8),
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
                    isLiked ? Colors.red : Colors.grey.withValues(alpha: 0.5),
                size: 30,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    return CachedNetworkImage(
      imageUrl: productList.image ?? '',
      height: 400,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder:
          (context, url) =>
              const Center(child: CircularProgressIndicator.adaptive()),
      errorWidget:
          (context, url, error) =>
              Icon(Icons.error, size: 50, color: AppColors.error),
    );
  }

  Widget _buildProductDetails(
    BuildContext context,
    double originalPrice,
    double discountedPrice,
    double discountPercentage,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductTitle(),
          const SizedBox(height: 8),
          _buildPriceRow(originalPrice, discountedPrice, discountPercentage),
          const SizedBox(height: 16),
          _buildProductDescription(),
          const SizedBox(height: 32),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  /// Builds the product title
  Widget _buildProductTitle() {
    return Text(
      productList.title ?? 'No Title',
      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  /// Builds the price information row
  Widget _buildPriceRow(
    double originalPrice,
    double discountedPrice,
    double discountPercentage,
  ) {
    return Row(
      children: [
        Text(
          '\$${discountedPrice.toStringAsFixed(2)}',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 14),
        if (originalPrice != 0)
          Text(
            '\$${originalPrice.toStringAsFixed(2)}',
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        const SizedBox(width: 14),
        if (discountPercentage != 0)
          Text(
            '${discountPercentage.toStringAsFixed(0)}% OFF',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget _buildProductDescription() {
    return Text(
      productList.description ?? 'No description available',
      style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
        color: AppColors.textSecondary,
        height: 1.5,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // Add your shopping bag functionality here
          },
          child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 32,
              color: AppColors.primary,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => ClothingFilterPopup(product: productList),
              ).then((result) {
                if (result != null) {
                  print('Selected: $result');
                }
              });
            },
            child: Text(
              'Add to Cart',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
