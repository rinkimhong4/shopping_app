// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:shopping_app/Modules/Home/models/product_model.dart';
// import 'package:shopping_app/configs/Theme/app_theme.dart';

// class DetailScreenNonAPI extends StatelessWidget {
//   final TShirtModel tShirt;

//   const DetailScreenNonAPI({super.key, required this.tShirt});

//   @override
//   Widget build(BuildContext context) {
//     final discount = tShirt.price != null ? tShirt.price! * 0.55 : 25;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(tShirt.title ?? 'Product Details'),
//         backgroundColor: AppColors.accent,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CachedNetworkImage(
//               imageUrl: tShirt.image ?? '',
//               height: 300,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               placeholder:
//                   (context, url) =>
//                       const Center(child: CircularProgressIndicator.adaptive()),
//               errorWidget:
//                   (context, url, error) =>
//                       const Icon(Icons.error, size: 50, color: AppColors.error),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     tShirt.title ?? 'No Title',
//                     style: AppTheme.lightTheme.textTheme.headlineSmall,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '\$${tShirt.price?.toStringAsFixed(2) ?? 'N/A'}',
//                     style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
//                       color: AppColors.primary,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Text(
//                         'Discount: ',
//                         style: AppTheme.lightTheme.textTheme.titleMedium
//                             ?.copyWith(color: AppColors.primary),
//                       ),
//                       Text(
//                         '\$${discount.toStringAsFixed(2)}',
//                         style: AppTheme.lightTheme.textTheme.titleMedium
//                             ?.copyWith(
//                               color: AppColors.error,
//                               decoration: TextDecoration.lineThrough,
//                             ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Placeholder add-to-cart action
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Added ${tShirt.title} to cart'),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary,
//                       minimumSize: const Size(double.infinity, 50),
//                     ),
//                     child: Text(
//                       'Add to Cart',
//                       style: AppTheme.lightTheme.textTheme.titleMedium
//                           ?.copyWith(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
