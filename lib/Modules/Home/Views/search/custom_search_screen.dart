// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:shopping_app/Modules/items/search_items.dart';
// import 'package:shopping_app/configs/Theme/app_theme.dart';

// class CustomSearchDelegate extends SearchDelegate<String> {
//   final List<String> _searchItems = [
//     'T-shirt',
//     'Jeans',
//     'Jacket',
//     'Dress',
//     'Sneakers',
//     'Hoodie',
//     'Skirt',
//     'Shorts',
//     'Sweater',
//     'Blazer',
//   ];
//   final List _imageSearch = [
//     'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/ec69f2c4-b6ca-4fde-a314-0acbd0cc2664/M+NRG+NOCTA+CS+TEE+SS.png',
//     'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/ec69f2c4-b6ca-4fde-a314-0acbd0cc2664/M+NRG+NOCTA+CS+TEE+SS.png',
//     'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/ec69f2c4-b6ca-4fde-a314-0acbd0cc2664/M+NRG+NOCTA+CS+TEE+SS.png',
//     'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/ec69f2c4-b6ca-4fde-a314-0acbd0cc2664/M+NRG+NOCTA+CS+TEE+SS.png',
//     'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/ec69f2c4-b6ca-4fde-a314-0acbd0cc2664/M+NRG+NOCTA+CS+TEE+SS.png',
//     'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/ec69f2c4-b6ca-4fde-a314-0acbd0cc2664/M+NRG+NOCTA+CS+TEE+SS.png',
//   ];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       if (query.isNotEmpty)
//         Container(
//           margin: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: AppColors.textSecondary.withValues(alpha: 0.2),
//             shape: BoxShape.circle,
//           ),
//           child: IconButton(
//             icon: Icon(Icons.clear, size: 18),
//             color: AppColors.textPrimary,
//             onPressed: () => query = '',
//           ),
//         ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     if (query.isEmpty) {
//       return GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: Padding(
//             padding: const EdgeInsets.only(top: 14, left: 24, right: 24),
//             child: GridView.count(
//               crossAxisCount: 3,
//               crossAxisSpacing: 14,
//               mainAxisSpacing: 14,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               children: List.generate(6, (index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder:
//                             (context) => DetailScreen(
//                               item: _searchItems[index % _searchItems.length],
//                             ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 120,
//                     width: 120,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                                 index < _imageSearch.length
//                                     ? _imageSearch[index]
//                                     : 'https://via.placeholder.com/150',
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         ),
//                         Container(
//                           width: double.infinity,
//                           height: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.black.withValues(alpha: 0.5),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Center(
//                             child: Text(
//                               _searchItems[index % _searchItems.length],
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ),
//       );
//     }

//     final suggestions =
//         _searchItems
//             .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//             .toList();

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: ListView.builder(
//           itemCount: suggestions.length,
//           itemBuilder:
//               (context, index) => ListTile(
//                 title: Text(suggestions[index]),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) => DetailScreen(item: suggestions[index]),
//                     ),
//                   );
//                 },
//               ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final List<String> resultList =
//         _searchItems
//             .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//             .toList();

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: AppColors.accent,
//         body:
//             resultList.isEmpty
//                 ? Center(
//                   child: Text(
//                     'No results found for "$query"',
//                     style: const TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 )
//                 : ListView.builder(
//                   itemCount: resultList.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(
//                         resultList[index],
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       onTap: () {
//                         // Navigate to DetailScreen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) =>
//                                     DetailScreen(item: resultList[index]),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//       ),
//     );
//   }

//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return theme.copyWith(
//       appBarTheme: const AppBarTheme(
//         backgroundColor: AppColors.accent,
//         elevation: 0,
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: InputBorder.none,
//         hintStyle: TextStyle(color: AppColors.textSecondary),
//       ),
//     );
//   }
// }
