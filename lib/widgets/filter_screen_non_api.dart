import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/models/product_model_fake_api.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class ClothingFilterPopupFake extends StatefulWidget {
  final Product product;
  final int initialQuantity;
  const ClothingFilterPopupFake({
    super.key,
    required this.product,
    required this.initialQuantity,
  });

  @override
  State<ClothingFilterPopupFake> createState() =>
      _ClothingFilterPopupFakeState();
}

class _ClothingFilterPopupFakeState extends State<ClothingFilterPopupFake> {
  String? selectedSize;
  Color? selectedColor;
  late int quantity;
  bool isFavorite = false;
  final colorNames = {
    Colors.black: 'Black',
    Colors.white: 'White',
    Colors.red: 'Red',
    Colors.blue: 'Blue',
    Colors.green: 'Green',
    Colors.yellow: 'Yellow',
  };

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void _applyFilters() {
    Get.back(
      result: {
        'size': selectedSize,
        'color': selectedColor,
        'quantity': quantity,
      },
    );
  }

  String calculateDiscountPercentage(String? price, String? discount) {
    final priceValue = double.tryParse(price ?? '0.0') ?? 0.0;
    final discountValue = double.tryParse(discount ?? '0.0') ?? 0.0;
    if (priceValue == 0.0) return '0.0';
    final percentage = (discountValue / priceValue) * 100;
    return percentage.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final originalPrice = double.tryParse(widget.product.price ?? '0.0') ?? 0.0;
    final discount = double.tryParse(widget.product.discount ?? '0.0') ?? 0.0;
    final discountedPrice = originalPrice;
    final discountPercentage = calculateDiscountPercentage(
      widget.product.price,
      widget.product.discount,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Divider(
            height: 30,
            thickness: 0.7,
            color: AppColors.textSecondary.withValues(alpha: 0.2),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: widget.product.image ?? '',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.error, size: 100),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title ?? 'Product Name',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (discount > 0)
                      Row(
                        children: [
                          Text(
                            '\$${discountedPrice.toStringAsFixed(2)}',
                            style: AppTheme.lightTheme.textTheme.bodyLarge
                                ?.copyWith(color: AppColors.primary),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '($discountPercentage% off)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        '\$${originalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 30,
            thickness: 0.7,
            color: AppColors.textSecondary.withValues(alpha: 0.2),
          ),
          _buildSectionTitle(
            'Choose your size${selectedSize != null ? ': $selectedSize' : ''}',
          ),
          Wrap(
            spacing: 14,
            children:
                ['XS', 'S', 'M', 'L', 'XL', 'XXL'].map((size) {
                  return ChoiceChip(
                    elevation: 0,
                    label: Text(size),
                    backgroundColor: Colors.white,
                    selected: selectedSize == size,
                    showCheckmark: false,
                    selectedColor: AppColors.primary.withValues(alpha: 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color:
                            selectedSize == size
                                ? AppColors.primary
                                : AppColors.textSecondary.withValues(
                                  alpha: 0.3,
                                ),
                        width: 1,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color:
                          selectedSize == size
                              ? AppColors.primary
                              : Colors.black,
                    ),
                    onSelected: (selected) {
                      setState(() {
                        selectedSize = selected ? size : null;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 30),
          _buildSectionTitle(
            'Choose a Color${selectedColor != null ? ': ${colorNames[selectedColor]}' : ''}',
          ),
          Wrap(
            spacing: 10,
            children:
                colorNames.keys.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.5),
                      radius: 19,
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: 18,
                        child:
                            selectedColor == color
                                ? const Icon(
                                  Icons.check,
                                  size: 24,
                                  color: Colors.white,
                                )
                                : null,
                      ),
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 30),
          _buildSectionTitle('Quantity'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CounterWidget(
                initialCount: widget.initialQuantity, // Pass initial quantity
                onCountChanged: (count) {
                  setState(() {
                    quantity = count;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: AppColors.primary,
              ),
              onPressed: _applyFilters,
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  final double borderRadius;
  final ValueChanged<int>? onCountChanged;
  final int initialCount;

  const CounterWidget({
    super.key,
    this.borderRadius = 100,
    this.onCountChanged,
    this.initialCount = 1,
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int count;
  bool isAddHovered = false;
  bool isRemoveHovered = false;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount; // Initialize from prop
  }

  void increment() {
    setState(() {
      count++;
      widget.onCountChanged?.call(count);
    });
  }

  void decrement() {
    setState(() {
      if (count > 1) {
        count--;
        widget.onCountChanged?.call(count);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onHover: (hover) => setState(() => isRemoveHovered = hover),
          onTap: decrement,
          child: Container(
            height: 44,
            width: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.primary.withValues(alpha: 0.4),
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: const Center(child: Icon(Icons.remove, size: 18)),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 44,
          width: 84,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.primary,
          ),
          child: Text(
            '$count',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onHover: (hover) => setState(() => isAddHovered = hover),
          onTap: increment,
          child: Container(
            height: 44,
            width: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.primary.withValues(alpha: 0.4),
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: const Center(child: Icon(Icons.add, size: 18)),
          ),
        ),
        if (count > 1) ...[
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              setState(() {
                count = 1;
                widget.onCountChanged?.call(count);
              });
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
