import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:shopping_app/widgets/filter_screen_non_api.dart';
import 'package:shopping_app/Modules/Home/models/product_model_fake_api.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/app_theme_controller.dart';

class DetainScreenNonAPI extends StatefulWidget {
  final Product product;
  const DetainScreenNonAPI({super.key, required this.product});

  @override
  State<DetainScreenNonAPI> createState() => _DetainScreenNonAPIState();
}

class _DetainScreenNonAPIState extends State<DetainScreenNonAPI> {
  int quantity = 1;
  bool isFavorite = false;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
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
      backgroundColor: Theme.of(context).cardColor,
      leading: BackButton(color: Theme.of(context).iconTheme.color),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: LikeButton(
            size: 30,
            circleColor: CircleColor(
              start: Theme.of(context).primaryColor.withValues(alpha: 0.7),
              end: Theme.of(context).primaryColor,
            ),
            bubblesColor: BubblesColor(
              dotPrimaryColor: Colors.pink,
              dotSecondaryColor: Theme.of(context).cardColor,
            ),
            likeBuilder: (bool isLiked) {
              return Icon(
                Icons.favorite,
                color:
                    isLiked
                        ? Colors.red
                        : Theme.of(
                          context,
                        ).iconTheme.color?.withValues(alpha: 0.5),
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
              (context, url) => Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
          errorWidget:
              (context, url, error) =>
                  Icon(Icons.error, size: 50, color: AppColors.error),
          fit: BoxFit.cover,
          height: 400,
          width: double.infinity,
        )
        : Center(
          child: Text(
            'No image available',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).hintColor,
            ),
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
          FadeInRight(
            duration: const Duration(milliseconds: 300),
            child: Text(
              product.title ?? '',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          FadeInRight(
            duration: const Duration(milliseconds: 400),
            child: _buildRating(),
          ),
          const SizedBox(height: 10),
          if (product.brand?.name != null &&
              product.brand!.name!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                FadeInRight(
                  duration: const Duration(milliseconds: 500),
                  child: Row(
                    children: [
                      if (product.brand?.logo != null) const SizedBox.shrink(),
                      Text(
                        'Brand: ',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: Theme.of(context).hintColor),
                      ),
                      Text(
                        product.brand!.name!,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              FadeInRight(
                duration: const Duration(milliseconds: 600),
                child: Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FadeInRight(
                duration: const Duration(milliseconds: 600),
                child:
                    discount > 0
                        ? Row(
                          children: [
                            const SizedBox(width: 10),
                            Text(
                              '\$${originalPrice.toStringAsFixed(2)}',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${calculateDiscountPercentage(product.price, product.discount)}% OFF',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.error),
                            ),
                          ],
                        )
                        : const SizedBox.shrink(),
              ),
            ],
          ),
          Divider(
            height: 30,
            thickness: 0.7,
            color: Theme.of(context).dividerColor,
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInRight(
                duration: const Duration(milliseconds: 650),
                child: Text(
                  'Description',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 14),
              FadeInRight(
                duration: const Duration(milliseconds: 650),
                child: Text(
                  product.description ?? 'No description available',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 38),
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
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: 14),
        Text(
          '(No reviews)',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Theme.of(context).hintColor),
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
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: LikeButton(
            size: 24,
            isLiked: isFavorite,
            circleColor: CircleColor(
              start: Theme.of(context).primaryColor.withValues(alpha: 0.7),
              end: Theme.of(context).primaryColor,
            ),
            bubblesColor: BubblesColor(
              dotPrimaryColor: Colors.pink,
              dotSecondaryColor: Theme.of(context).cardColor,
            ),
            likeBuilder: (bool isLiked) {
              return SvgPicture.asset(
                isLiked
                    ? 'assets/icons/bag-fill.svg'
                    : 'assets/icons/bag-outline.svg',
                colorFilter: ColorFilter.mode(
                  isLiked ? AppColors.error : Theme.of(context).primaryColor,
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
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
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
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
