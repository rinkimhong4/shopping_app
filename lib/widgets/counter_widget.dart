// import 'package:flutter/material.dart';

// class CounterWidget extends StatefulWidget {
//   final double borderRadius;
//   final ValueChanged<int>? onCountChanged;

//   const CounterWidget({
//     super.key,
//     this.borderRadius = 100,
//     this.onCountChanged,
//   });

//   @override
//   State<CounterWidget> createState() => _CounterWidgetState();
// }

// class _CounterWidgetState extends State<CounterWidget> {
//   bool isAddHovered = false;
//   bool isRemoveHovered = false;
//   int count = 1;

//   void increment() {
//     setState(() {
//       count++;
//       widget.onCountChanged?.call(count);
//     });
//   }

//   void decrement() {
//     setState(() {
//       if (count > 1) {
//         count--;
//         widget.onCountChanged?.call(count);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         InkWell(
//           onHover: (hover) => setState(() => isRemoveHovered = hover),
//           onTap: decrement,
//           child: Container(
//             height: 20,
//             width: 20,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               border: Border.all(width: 1, color: Colors.white),
//               borderRadius: BorderRadius.circular(widget.borderRadius),
//               color: isRemoveHovered ? const Color(0xFF00BAAB) : null,
//             ),
//             child: const Center(child: Icon(Icons.remove, size: 15)),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Container(
//           height: 44,
//           width: 84,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: Colors.white,
//           ),
//           child: Text(
//             '$count',
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         InkWell(
//           onHover: (hover) => setState(() => isAddHovered = hover),
//           onTap: increment,
//           child: Container(
//             height: 20,
//             width: 20,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               border: Border.all(width: 1, color: Colors.white),
//               borderRadius: BorderRadius.circular(widget.borderRadius),
//               color: isAddHovered ? const Color(0xFF00BAAB) : null,
//             ),
//             child: const Center(child: Icon(Icons.add, size: 15)),
//           ),
//         ),
//       ],
//     );
//   }
// }
