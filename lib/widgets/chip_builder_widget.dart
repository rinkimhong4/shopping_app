import 'package:flutter/material.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class CustomChipBuilderWidget extends StatefulWidget {
  const CustomChipBuilderWidget({super.key});

  @override
  State<CustomChipBuilderWidget> createState() =>
      _CustomChipBuilderWidgetState();
}

class _CustomChipBuilderWidgetState extends State<CustomChipBuilderWidget> {
  List<String> chipData = [
    'T-shirt',
    'Jeans',
    'Jacket',
    'Dress',
    'Shoes',
    'Hoodie',
    'Skirt',
    'Shorts',
  ];
  List<bool> selectedChips = List.generate(
    8,
    (_) => false,
  ); // Track selection state

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 2,
          children: List.generate(
            chipData.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedChips[index] = !selectedChips[index];
                });
              },
              child: Chip(
                onDeleted: () {
                  setState(() {
                    chipData.removeAt(index);
                    selectedChips.removeAt(index);
                  });
                },
                deleteIcon: Icon(
                  Icons.close,
                  size: 18,
                  color:
                      selectedChips[index]
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary,
                ),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.black.withValues(alpha: 0.3)),
                ),
                label: Text(
                  chipData[index],
                  style: TextStyle(
                    color:
                        selectedChips[index]
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                  ),
                ),
                backgroundColor:
                    selectedChips[index] ? AppColors.primary : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
