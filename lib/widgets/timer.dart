// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({super.key});

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int hour;
  late int minute;
  late String period;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _startTimer();
  }

  void _updateTime() {
    final currentDate = DateTime.now();
    setState(() {
      hour =
          currentDate.hour > 12
              ? currentDate.hour - 12
              : (currentDate.hour == 0 ? 12 : currentDate.hour);
      minute = currentDate.minute;
      period = currentDate.hour >= 12 ? 'PM' : 'AM';
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Hour
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            hour.toString().padLeft(2, '0'),
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: 4),
        // Colon
        Text(":", style: AppTheme.lightTheme.textTheme.bodyMedium),
        const SizedBox(width: 4),
        // Minute
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            minute.toString().padLeft(2, '0'),
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: 8),
        // AM/PM
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(period, style: AppTheme.lightTheme.textTheme.bodyMedium),
        ),
      ],
    );
  }
}
