import 'package:flutter/material.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class SliderDiscountWidget extends StatefulWidget {
  const SliderDiscountWidget({super.key});

  @override
  State<SliderDiscountWidget> createState() => _SliderDiscountWidgetState();
}

class _SliderDiscountWidgetState extends State<SliderDiscountWidget> {
  double _currentValue = 30;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text('Discount', style: TextStyle(fontWeight: FontWeight.w500)),
              Spacer(),
              Text(
                '${_currentValue.toInt()} %',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 14,
            mouseCursor: WidgetStatePropertyAll(MouseCursor.uncontrolled),
            overlayShape: SliderComponentShape.noOverlay,
            activeTrackColor: AppColors.primary,
            thumbColor: AppColors.primary,
            thumbSize: WidgetStatePropertyAll(Size.zero),
            inactiveTrackColor: Colors.grey,
          ),
          child: Slider(
            min: 0,
            max: 100,
            value: _currentValue,
            onChanged: (value) {
              setState(() {
                _currentValue = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

class SliderPriceRangeWidget extends StatefulWidget {
  const SliderPriceRangeWidget({super.key});

  @override
  State<SliderPriceRangeWidget> createState() => _SliderPriceRangeWidgetState();
}

class _SliderPriceRangeWidgetState extends State<SliderPriceRangeWidget> {
  double _currentValue = 11.59;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Price Range',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                '${_currentValue.toInt()} \$',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 14,
            mouseCursor: WidgetStatePropertyAll(MouseCursor.uncontrolled),
            overlayShape: SliderComponentShape.noOverlay,
            activeTrackColor: AppColors.primary,
            thumbColor: AppColors.primary,
            thumbSize: WidgetStatePropertyAll(Size.zero),
            inactiveTrackColor: Colors.grey,
          ),
          child: Slider(
            min: 5,
            max: 2000,
            value: _currentValue,
            onChanged: (value) {
              setState(() {
                _currentValue = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
