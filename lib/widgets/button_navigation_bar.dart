import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/Modules/AppAssets/app_assets.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class ButtonNavigationWidget extends StatefulWidget {
  final void Function(int)? onTap;
  final int? selectedIndex;

  const ButtonNavigationWidget({super.key, this.onTap, this.selectedIndex});

  @override
  State<ButtonNavigationWidget> createState() => _ButtonNavigationWidgetState();
}

class _ButtonNavigationWidgetState extends State<ButtonNavigationWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<({String filled, String outlined, String label})> iconList = [
      (
        filled: AppAssets.homeFill,
        outlined: AppAssets.homeOutline,
        label: 'Home',
      ),
      (
        filled: AppAssets.searchFill,
        outlined: AppAssets.searchOutline,
        label: 'Search',
      ),
      (filled: AppAssets.bagFill, outlined: AppAssets.bagOutline, label: 'Bag'),
      (
        filled: AppAssets.personFill,
        outlined: AppAssets.personOutline,
        label: 'Profile',
      ),
    ];
    return Stack(
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(iconList.length, (index) {
                  return GestureDetector(
                    onTap: () => _onItemTapped(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          _selectedIndex == index
                              ? iconList[index].filled
                              : iconList[index].outlined,
                          colorFilter: ColorFilter.mode(
                            _selectedIndex == index
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(height: 5),
                        Text(
                          iconList[index].label,
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                                color:
                                    _selectedIndex == index
                                        ? AppColors.primary
                                        : AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
