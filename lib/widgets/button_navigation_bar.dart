import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/configs/AppAssets/app_assets.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Modules/Home/controller/app_theme_controller.dart';

class ButtonNavigationWidget extends StatefulWidget {
  final void Function(int)? onTap;
  final int? selectedIndex;

  const ButtonNavigationWidget({super.key, this.onTap, this.selectedIndex});

  @override
  State<ButtonNavigationWidget> createState() => _ButtonNavigationWidgetState();
}

class _ButtonNavigationWidgetState extends State<ButtonNavigationWidget> {
  int _selectedIndex = 0;
  final themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTap?.call(index);
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
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(iconList.length, (index) {
                  final isSelected = _selectedIndex == index;
                  final iconColor =
                      isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).hintColor;
                  final textColor =
                      isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).hintColor;

                  return GestureDetector(
                    onTap: () => _onItemTapped(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          isSelected
                              ? iconList[index].filled
                              : iconList[index].outlined,
                          colorFilter: ColorFilter.mode(
                            iconColor,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          iconList[index].label,
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(color: textColor),
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
