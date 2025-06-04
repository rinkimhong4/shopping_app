// Sample DetailScreen to navigate to
import 'package:flutter/material.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class DetailScreen extends StatelessWidget {
  final String item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$item Details'),
        backgroundColor: AppColors.accent,
      ),
      body: Center(
        child: Text('Details for $item', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
