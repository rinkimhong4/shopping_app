import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/bag_controller.dart';
import 'package:shopping_app/configs/AppAssets/app_assets.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class MyOrdersItems extends StatelessWidget {
  const MyOrdersItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        elevation: 0,
        centerTitle: true,

        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: const ProductList(),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final BagController bagController = Get.find<BagController>();

    return Obx(() {
      final productsList = bagController.cartItems;
      if (productsList.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/b.webp', height: 250),
                Text(
                  'No Orders Yet',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Your orders will appear here once you make a purchase.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color:
                        Theme.of(context).textTheme.bodySmall?.color ??
                        AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProductCard(
                  product: productsList[index],
                  index: index,
                  onRemove:
                      () => bagController.removeFromCart(
                        productsList[index]['id'],
                        size: productsList[index]['size'],
                        color: productsList[index]['color'],
                      ),
                ),
                childCount: productsList.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '\$${bagController.getTotalAmount().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final int index;
  final VoidCallback onRemove;

  const ProductCard({
    super.key,
    required this.product,
    required this.index,
    required this.onRemove,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late int quantity;
  final colorNames = {
    Colors.black.toString(): 'Black',
    Colors.white.toString(): 'White',
    Colors.red.toString(): 'Red',
    Colors.blue.toString(): 'Blue',
    Colors.green.toString(): 'Green',
    Colors.yellow.toString(): 'Yellow',
  };

  @override
  void initState() {
    super.initState();
    quantity = (widget.product['quantity'] as num?)?.toInt() ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    final price = double.tryParse(widget.product['price'].toString()) ?? 0.0;
    final discount =
        double.tryParse(widget.product['discount'].toString()) ?? 0.0;
    final discountedPrice = price - discount;
    final size = widget.product['size'] as String?;
    final color = widget.product['color'] as String?;
    final priceRange = widget.product['priceRange'] as Map<String, dynamic>?;

    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 140,
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            // Product Image
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.product['image'] ?? '',
                  width: 85,
                  height: 85,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            // Product Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product Name and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product['title'] ?? 'No Title',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            AppAssets.trash,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).iconTheme.color ?? Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          onPressed: widget.onRemove,
                        ),
                      ],
                    ),
                    // Size, Color, and Price Range
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (size != null)
                              Text(
                                'Size: $size',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            if (size != null && color != null)
                              const SizedBox(width: 16),
                            if (color != null)
                              Text(
                                'Color: ${colorNames[color] ?? 'Unknown'}',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                          ],
                        ),
                        if (priceRange != null)
                          Text(
                            'Price Range: \$${priceRange['start'].toStringAsFixed(2)} - \$${priceRange['end'].toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Theme.of(context).hintColor),
                          ),
                      ],
                    ),
                    // Price and Counter
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '\$${(discountedPrice * quantity).toStringAsFixed(2)}',
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (discount > 0) ...[
                              const SizedBox(width: 8),
                              Text(
                                '\$${(price * quantity).toStringAsFixed(2)}',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                        CounterWidget(
                          borderRadius: 8,
                          initialCount: quantity,
                          onCountChanged:
                              (count) => setState(() {
                                quantity = count;
                                widget.product['quantity'] = count;
                                Get.find<BagController>().updateQuantity(
                                  widget.product['id'],
                                  count,
                                  size: widget.product['size'],
                                  color: widget.product['color'],
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
    this.borderRadius = 8,
    this.onCountChanged,
    this.initialCount = 1,
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  bool isAddHovered = false;
  bool isRemoveHovered = false;
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
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
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onHover: (hover) => setState(() => isRemoveHovered = hover),
            onTap: decrement,
            child: Container(
              height: 28,
              width: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade600.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: const Icon(Icons.remove, size: 16, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 36,
            child: Text(
              '$count',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onHover: (hover) => setState(() => isAddHovered = hover),
            onTap: increment,
            child: Container(
              height: 28,
              width: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade600.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: const Icon(Icons.add, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
