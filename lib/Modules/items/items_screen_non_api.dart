import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:shopping_app/widgets/filter_screen_non_api.dart';
import 'package:shopping_app/Modules/Home/models/product_model_fake_api.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class DetainScreenNonAPI extends StatefulWidget {
  final Product product;
  const DetainScreenNonAPI({super.key, required this.product});

  @override
  State<DetainScreenNonAPI> createState() => _DetainScreenNonAPIState();
}

class _DetainScreenNonAPIState extends State<DetainScreenNonAPI> {
  int quantity = 1;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildProductImage(), _buildProductDetails(context)],
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
    final imageUrl = widget.product.image ?? '';
    return imageUrl.isNotEmpty
        ? CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder:
              (context, url) =>
                  const Center(child: CircularProgressIndicator()),
          errorWidget:
              (context, url, error) => const Icon(Icons.error, size: 50),
          fit: BoxFit.cover,
          height: 400,
          width: double.infinity,
        )
        : const Center(
          child: Text(
            'No image available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
  }

  Widget _buildProductDetails(BuildContext context) {
    final product = widget.product;
    final price = double.tryParse(product.price ?? '0.0') ?? 0.0;
    final discount = double.tryParse(product.discount ?? '0.0') ?? 0.0;
    final originalPrice = price + discount;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title ?? 'Product Title',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildRating(),
          SizedBox(height: 10),
          if (product.brand != null) ...[
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Brand: ',
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  product.brand.toString().split('.').last,
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.primary,
                ),
              ),
              if (discount > 0) ...[
                const SizedBox(width: 10),
                Text(
                  '\$${originalPrice.toStringAsFixed(2)}',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '${calculateDiscountPercentage(product.price, product.discount)}% OFF',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ],
          ),
          Divider(
            height: 30,
            thickness: 0.7,
            color: AppColors.textSecondary.withValues(alpha: 0.2),
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: AppTheme.lightTheme.textTheme.titleSmall,
              ),
              const SizedBox(height: 14),
              Text(
                product.description ?? 'No description available',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 38),
              _buildActionButtons(context),
            ],
          ),
        ],
      ),
    );
  }

  String calculateDiscountPercentage(String? price, String? discount) {
    final priceValue = double.tryParse(price ?? '0.0') ?? 0.0;
    final discountValue = double.tryParse(discount ?? '0.0') ?? 0.0;
    if (priceValue + discountValue == 0.0) return '0.0';
    final percentage = (discountValue / (priceValue + discountValue)) * 100;
    return percentage.toStringAsFixed(1);
  }

  Widget _buildRating() {
    final product = widget.product;
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 10),
        Text(
          (double.tryParse(product.rate ?? '0.0')?.toStringAsFixed(1)) ?? '0.0',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        const SizedBox(width: 14),
        Text(
          '(No reviews)',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
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
                    (context) => ClothingFilterPopupFake(
                      product: widget.product,
                      initialQuantity: quantity,
                    ),
              ).then((result) {
                if (result != null) {
                  setState(() {
                    quantity = result['quantity'] ?? quantity;
                  });
                }
              });
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
