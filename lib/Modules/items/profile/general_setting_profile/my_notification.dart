import 'package:flutter/material.dart';

class MyNotificationItems extends StatelessWidget {
  const MyNotificationItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notification')),
      body: Center(
        child: Text(
          'My Notification Items',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
