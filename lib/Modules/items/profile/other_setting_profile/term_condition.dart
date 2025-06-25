import 'package:flutter/material.dart';

class TermConditionItems extends StatelessWidget {
  const TermConditionItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms and Conditions')),
      body: Center(
        child: Text(
          'Terms and Conditions Screen',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
