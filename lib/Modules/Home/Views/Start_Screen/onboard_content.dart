// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:shopping_app/configs/Theme/app_theme.dart';

// class OnboardContent extends StatelessWidget {
//   const OnboardContent({
//     super.key,
//     required this.imageSlider,
//     required this.title,
//     required this.subTitle,
//   });
//   final String? imageSlider, title, subTitle;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         children: [
//           Expanded(
//             child: CachedNetworkImage(
//               imageUrl: imageSlider!,
//               fit: BoxFit.cover,
//               imageBuilder:
//                   (context, imageProvider) => Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       image: DecorationImage(
//                         image: imageProvider,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//             ),
//           ),
//           SizedBox(height: 24),
//           Text(title!, style: AppTheme.lightTheme.textTheme.titleLarge),
//           SizedBox(height: 8),
//           Text(
//             subTitle!,
//             style: AppTheme.lightTheme.textTheme.labelSmall,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
