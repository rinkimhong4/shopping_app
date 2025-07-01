import 'package:flutter/material.dart';

class MyOrdersItems extends StatelessWidget {
  const MyOrdersItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: Center(
        child: Text(
          'My Orders Items',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
