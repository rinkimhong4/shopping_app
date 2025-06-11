import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/models/product_model.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class ClothingFilterPopup extends StatefulWidget {
  final TShirtModel product;
  const ClothingFilterPopup({super.key, required this.product});

  @override
  State<ClothingFilterPopup> createState() => _ClothingFilterPopupState();
}

class _ClothingFilterPopupState extends State<ClothingFilterPopup> {
  String? selectedSize;
  Color? selectedColor;
  int quantity = 1;
  RangeValues priceRange = RangeValues(0, 10);

  final colorNames = {
    Colors.black: 'Black',
    Colors.white: 'White',
    Colors.red: 'Red',
    Colors.blue: 'Blue',
    Colors.green: 'Green',
    Colors.yellow: 'Yellow',
  };

  void _applyFilters() {
    Get.back(
      result: {
        'size': selectedSize,
        'color': selectedColor,
        'quantity': quantity,
        'priceRange': priceRange,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final originalPrice = widget.product.price ?? 0.0;
    final discount = originalPrice * 0.45;
    final discountedPrice = originalPrice - discount;
    final discountPercentage = (discount / originalPrice * 100).round();

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
          // Header
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
          // Product Info
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
                      (context, url, error) => Icon(Icons.error, size: 100),
                ),
              ),
              SizedBox(width: 16),
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
                    SizedBox(height: 8),
                    if (discountPercentage > 0)
                      Row(
                        children: [
                          Text(
                            '\$${discountedPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '\$${originalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '$discountPercentage% OFF',
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        ],
                      )
                    else
                      Text(
                        '\$${originalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
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
            'Choose your size: ${selectedSize != null ? ': $selectedSize' : ''}',
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
                    color: WidgetStateProperty.all(AppColors.background),
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
                    // selectedColor: AppColors.primary.withValues(alpha: 0.2),
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
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 30),
          _buildSectionTitle(
            'Choose a Color: ${selectedColor != null ? ' ${colorNames[selectedColor]}' : ''}',
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
                                ? Icon(
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
          SizedBox(height: 30),
          _buildSectionTitle('Quantity'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CounterWidget(
                onCountChanged: (count) {
                  setState(() {
                    quantity = count;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 30),
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
              child: Text(
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
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

// Enhanced CounterWidget with callback
class CounterWidget extends StatefulWidget {
  final double borderRadius;
  final ValueChanged<int>? onCountChanged;
  TShirtModel? tShirtModel;

  CounterWidget({
    super.key,
    this.borderRadius = 100,
    this.onCountChanged,
    this.tShirtModel,
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  bool isAddHovered = false;
  bool isRemoveHovered = false;
  int count = 0;

  void increment() {
    setState(() {
      count++;
      widget.onCountChanged?.call(count);
    });
  }

  void decrement() {
    setState(() {
      if (count > 0) {
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
            child: Center(child: Icon(Icons.remove, size: 18)),
          ),
        ),
        SizedBox(width: 10),
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        // Add product
        SizedBox(width: 10),
        InkWell(
          onTap: increment,
          child: Row(
            children: [
              Container(
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
                child: Center(child: Icon(Icons.add, size: 18)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      count = 0;
                    });
                    count = 0;
                  },
                  child:
                      count > 0
                          ? Text(
                            'Cancel',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
