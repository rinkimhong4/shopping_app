import 'package:flutter/material.dart';

class AboutUsItems extends StatelessWidget {
  const AboutUsItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: Center(
        child: Text(
          'About Us Screen',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
