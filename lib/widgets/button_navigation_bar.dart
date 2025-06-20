import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final List<({String filled, String outlined})> iconList = [
      (
        filled: 'assets/icons/home-fill.svg',
        outlined: 'assets/icons/home-outline.svg',
      ),
      (
        filled: 'assets/icons/search-fill.svg',
        outlined: 'assets/icons/search-outline.svg',
      ),
      (
        filled: 'assets/icons/bag-fill.svg',
        outlined: 'assets/icons/bag-outline.svg',
      ),
      (
        filled: 'assets/icons/person-fill.svg',
        outlined: 'assets/icons/person-outline.svg',
      ),
    ];
    return Stack(
      children: [
        ClipRRect(
          // borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 78,
              decoration: const BoxDecoration(
                color: Colors.white70,
                // borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(iconList.length, (index) {
                  return IconButton(
                    onPressed: () => _onItemTapped(index),
                    icon: SvgPicture.asset(
                      _selectedIndex == index
                          ? iconList[index].filled
                          : iconList[index].outlined,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == index
                            ? AppColors.primary
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                      width: 28,
                      height: 28,
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
