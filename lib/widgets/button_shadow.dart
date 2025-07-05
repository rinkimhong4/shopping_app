import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class NeumorphicButtonWidget extends StatelessWidget {
  final String? label;
  final VoidCallback onPressed;
  final Icon? icon;

  const NeumorphicButtonWidget({
    super.key,
    this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
        depth: 2,
        intensity: 0.9,
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        color: AppColors.primary,
        shadowDarkColorEmboss: AppColors.error,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 170, vertical: 14),
      child: Text(
        label!,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.accent,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
