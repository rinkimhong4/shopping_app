import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'OTP Screen',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
