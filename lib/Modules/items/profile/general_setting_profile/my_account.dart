import 'package:flutter/material.dart';

class MyAccountItems extends StatelessWidget {
  const MyAccountItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Account')),
      body: Center(
        child: Text(
          'My Account Items',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
