import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:shopping_app/widgets/filter_screen.dart';
import 'package:shopping_app/Modules/Home/models/product_model_api.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class DetailScreen extends StatefulWidget {
  final TShirtModel productList;

  const DetailScreen({super.key, required this.productList});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final double price = widget.productList.price ?? 0.0;
    final Rating? rating = widget.productList.rating;
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.accent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            _buildProductDetails(context, price, rating),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.accent,
      leading: const BackButton(color: Colors.black),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
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
            isLiked: isFavorite,
            onTap: (isLiked) async {
              setState(() {
                isFavorite = !isLiked;
              });
              return !isLiked;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    return CachedNetworkImage(
      imageUrl: widget.productList.image ?? '',
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
    double price,
    Rating? rating,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductTitle(),
          SizedBox(height: 10),
          if (rating != null) _buildRating(rating),
          SizedBox(height: 14),
          _buildPrice(price),
          SizedBox(height: 16),
          Divider(
            height: 30,
            thickness: 0.7,
            color: AppColors.textSecondary.withValues(alpha: 0.2),
          ),
          _buildProductDescription(),
          SizedBox(height: 32),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildProductTitle() {
    return Text(
      widget.productList.title ?? '',
      style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(),
    );
  }

  Widget _buildRating(Rating rating) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 20),
        SizedBox(width: 10),
        Text(
          rating.rate?.toStringAsFixed(1) ?? '0.0',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        SizedBox(width: 14),
        Text(
          '(${rating.count ?? 0} reviews)',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildPrice(double price) {
    final originalPrice = widget.productList.price ?? 0.0;
    final discount = originalPrice * 0.45;
    final discountedPrice = originalPrice - discount;
    final discountPercentage =
        originalPrice != 0 ? (discount / originalPrice * 100).round() : 0;

    return originalPrice != 0
        ? Row(
          children: [
            Text(
              '\$${discountedPrice.toStringAsFixed(2)}',
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '\$${originalPrice.toStringAsFixed(2)}',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                decoration: TextDecoration.lineThrough,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '$discountPercentage% OFF',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppColors.error,
              ),
            ),
          ],
        )
        : Text(
          '\$${originalPrice.toStringAsFixed(2)}',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        );
  }

  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: AppTheme.lightTheme.textTheme.titleSmall),
        SizedBox(height: 14),
        Text(
          widget.productList.description ?? 'No description available',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: LikeButton(
            size: 24,
            isLiked: isFavorite,
            circleColor: const CircleColor(
              start: Color(0xff00ddff),
              end: Color(0xff0099cc),
            ),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: Colors.pink,
              dotSecondaryColor: Colors.white,
            ),
            likeBuilder: (bool isLiked) {
              return SvgPicture.asset(
                isLiked
                    ? 'assets/icons/bag-fill.svg'
                    : 'assets/icons/bag-outline.svg',
                colorFilter: ColorFilter.mode(
                  isLiked ? AppColors.error : AppColors.primary,
                  BlendMode.srcIn,
                ),
                width: 28,
                height: 28,
              );
            },
            onTap: (isLiked) async {
              setState(() {
                isFavorite = !isLiked;
              });
              return !isLiked;
            },
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
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
                builder:
                    (context) =>
                        ClothingFilterPopup(product: widget.productList),
              );
            },
            child: Text(
              'Add to Cart',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
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
