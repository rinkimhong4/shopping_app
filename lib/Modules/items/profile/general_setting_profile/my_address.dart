import 'package:flutter/material.dart';

class MyAddressItems extends StatelessWidget {
  const MyAddressItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Address')),
      body: Center(
        child: Text(
          'My Address Items',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
