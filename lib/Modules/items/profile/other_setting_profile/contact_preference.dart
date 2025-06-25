import 'package:flutter/material.dart';

class ContactPreferenceItems extends StatelessWidget {
  const ContactPreferenceItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Preference')),
      body: Center(
        child: Text(
          'Contact Preference Screen',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
