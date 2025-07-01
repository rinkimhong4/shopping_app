import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:shopping_app/widgets/filter_screen.dart';
import 'package:shopping_app/Modules/Home/models/product_model_api.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/app_theme_controller.dart';

class DetailScreen extends StatefulWidget {
  final TShirtModel productList;

  const DetailScreen({super.key, required this.productList});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  bool isFavorite = false;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final double price = widget.productList.price ?? 0.0;
    final Rating? rating = widget.productList.rating;
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Theme.of(context).cardColor,
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
    return CachedNetworkImage(
      imageUrl: widget.productList.image ?? '',
      height: 400,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder:
          (context, url) => Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
      errorWidget:
          (context, url, error) => Icon(
            Icons.error,
            size: 50,
            color: AppColors.error, // Keep error color consistent
          ),
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
          FadeInRight(
            duration: Duration(milliseconds: 300),
            child: _buildProductTitle(),
          ),
          SizedBox(height: 10),
          FadeInRight(
            duration: Duration(milliseconds: 400),
            child: rating != null ? _buildRating(rating) : SizedBox(),
          ),
          SizedBox(height: 14),
          FadeInRight(
            duration: Duration(milliseconds: 400),
            child: _buildPrice(price),
          ),
          SizedBox(height: 16),
          Divider(
            height: 30,
            thickness: 0.7,
            color: Theme.of(context).dividerColor,
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
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildRating(Rating rating) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 20),
        SizedBox(width: 10),
        Text(
          rating.rate?.toStringAsFixed(1) ?? '0.0',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(width: 14),
        Text(
          '(${rating.count ?? 0} reviews)',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Theme.of(context).hintColor),
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
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '\$${originalPrice.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                decoration: TextDecoration.lineThrough,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '$discountPercentage% OFF',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.error, // Keep error color consistent
              ),
            ),
          ],
        )
        : Text(
          '\$${originalPrice.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleLarge,
        );
  }

  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInRight(
          duration: Duration(milliseconds: 500),
          child: Text(
            'Description',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 14),
        FadeInRight(
          duration: Duration(milliseconds: 550),
          child: Text(
            widget.productList.description ?? 'No description available',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).hintColor,
              height: 1.5,
            ),
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
                  isLiked
                      ? AppColors
                          .error // Keep error color consistent
                      : Theme.of(context).primaryColor,
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
                    (context) =>
                        ClothingFilterPopup(product: widget.productList),
              );
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
