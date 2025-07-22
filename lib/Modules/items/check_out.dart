// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shopping_app/configs/AppAssets/app_assets.dart';
import 'package:shopping_app/configs/Route/app_route.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';
import 'package:shopping_app/Modules/Home/controller/bag_controller.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String? selectedPaymentMethod;
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    final BagController bagController = Get.find<BagController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Row(
          children: [
            Text('Checkout', style: Theme.of(context).textTheme.titleLarge),
            Text(
              '.',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final cartItems = bagController.cartItems;
        final double subTotal = cartItems.fold(0.0, (sum, item) {
          final price = double.tryParse(item['price'].toString()) ?? 0.0;
          final discount = double.tryParse(item['discount'].toString()) ?? 0.0;
          final quantity = (item['quantity'] as num?)?.toInt() ?? 1;
          return sum + ((price - discount) * quantity);
        });
        const double delivery = 2.0;
        const double vatPercentage = 20;
        final double vat = (vatPercentage / 100) * delivery;
        final double totalAmount = subTotal + delivery + vat;

        return CustomScrollView(
          slivers: [
            // Product List
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver:
                  cartItems.isEmpty
                      ? SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/b.webp', height: 250),
                            Text(
                              'No items to checkout',
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              'Add items to your bag to proceed.',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color ??
                                    AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                      : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final item = cartItems[index];
                          return _buildProductCard(context, item);
                        }, childCount: cartItems.length),
                      ),
            ),
            // Order Summary
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Summary',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow(context, 'Subtotal', subTotal),
                    _buildSummaryRow(context, 'Delivery', delivery),
                    _buildSummaryRow(context, 'VAT (20%)', vat),
                    const Divider(height: 32, thickness: 0.7),
                    _buildSummaryRow(
                      context,
                      'Total Amount',
                      totalAmount,
                      isTotal: true,
                    ),
                    Divider(height: 32, thickness: 0.5),
                    // Delivery Type
                    _buildDeliveryType(),
                    // SizedBox(height: 32),
                    // Payment Methods
                    Divider(height: 32, thickness: 0.5),
                    Text(
                      'Payment Methods',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildPaymentMethods(context, AppAssets.aba, 'aba'),
                        const SizedBox(width: 16),
                        _buildPaymentMethods(
                          context,
                          AppAssets.acleda,
                          'acleda',
                        ),
                        const SizedBox(width: 16),
                        _buildPaymentMethods(context, AppAssets.wing, 'wing'),
                        const SizedBox(width: 16),
                        _buildPaymentMethods(context, AppAssets.ftb, 'ftb'),
                      ],
                    ),
                    SizedBox(height: 32),
                    // Pay Button
                    ElevatedButton(
                      onPressed:
                          selectedPaymentMethod == null
                              ? null
                              : () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder:
                                      (context) => Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: Center(
                                          child: SpinKitFadingCircle(
                                            size: 80,
                                            color: AppColors.success,
                                          ),
                                        ),
                                      ),
                                );

                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.of(context).pop();
                                  QuickAlert.show(
                                    context: context,
                                    backgroundColor: Colors.white,
                                    animType: QuickAlertAnimType.scale,
                                    type: QuickAlertType.success,
                                    title: 'Success',
                                    titleColor: AppColors.success,
                                    confirmBtnColor: AppColors.success,
                                    text: 'Transaction Completed Successfully!',
                                    confirmBtnText: 'Done',
                                    barrierColor: Colors.black54,
                                    onConfirmBtnTap: () {
                                      Get.toNamed(AppRoute.home);
                                    },
                                  );
                                });
                              },

                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 52),
                        backgroundColor: Theme.of(context).primaryColor,
                        disabledBackgroundColor:
                            Theme.of(context).disabledColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Pay',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDeliveryType() {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery by',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Column(
          children: [
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  value: _isChecked1,
                  onChanged: (value) {
                    setState(() {
                      _isChecked1 = value!;
                    });
                  },
                ),
                Text('J&T'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  value: _isChecked2,
                  onChanged: (value) {
                    setState(() {
                      _isChecked2 = value!;
                    });
                  },
                ),
                Text('Vireak Buntham Express'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> item) {
    final price = double.tryParse(item['price'].toString()) ?? 0.0;
    final discount = double.tryParse(item['discount'].toString()) ?? 0.0;
    final discountedPrice = price - discount;
    final quantity = (item['quantity'] as num?)?.toInt() ?? 1;
    final size = item['size'] as String?;
    final color = item['color'] as String?;
    final colorNames = {
      Colors.black.toString(): 'Black',
      Colors.white.toString(): 'White',
      Colors.red.toString(): 'Red',
      Colors.blue.toString(): 'Blue',
      Colors.green.toString(): 'Green',
      Colors.yellow.toString(): 'Yellow',
    };

    return Container(
      height: 120,
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
                imageUrl: item['image'] ?? '',
                width: 80,
                height: 80,
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
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Product Name
                  Text(
                    item['title'] ?? 'No Title',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      if (size != null)
                        Text(
                          'Size: $size',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Theme.of(context).hintColor),
                        ),
                      if (size != null && color != null)
                        const SizedBox(width: 16),
                      if (color != null)
                        Text(
                          'Color: ${colorNames[color] ?? 'Unknown'}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Theme.of(context).hintColor),
                        ),
                    ],
                  ),
                  // Price and Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '\$${(discountedPrice * quantity).toStringAsFixed(2)}',
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(
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
                      Text(
                        '$quantity x',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    double amount, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.bold,
              color:
                  isTotal
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(
    BuildContext context,
    String assetPath,
    String methodId,
  ) {
    final bool isSelected = selectedPaymentMethod == methodId;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = isSelected ? null : methodId;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).dividerColor,
          ),
        ),
        child: Image.asset(assetPath, width: 32, height: 32),
      ),
    );
  }
}
