import 'package:flutter/material.dart';

class CustomerSupportItems extends StatelessWidget {
  const CustomerSupportItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Support')),
      body: Center(
        child: Text(
          'Customer Support Screen',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
