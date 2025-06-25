import 'package:flutter/material.dart';

class PaymentMethodsItems extends StatelessWidget {
  const PaymentMethodsItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Methods')),
      body: Center(
        child: Text('Payment Methods Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
