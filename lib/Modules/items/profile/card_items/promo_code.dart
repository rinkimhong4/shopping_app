import 'package:flutter/material.dart';

class PromoCodeItems extends StatelessWidget {
  const PromoCodeItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Promo Code')),
      body: Center(
        child: Text(
          'Promo Code Items',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
