import 'package:flutter/material.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class LogOutButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final IconData? icon;
  const LogOutButton({
    required this.text,
    required this.onPressed,
    this.icon = Icons.arrow_forward_ios,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = AppColors.error;
    const double borderRadius = 14;
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: WidgetStateProperty.all(
          BorderSide(color: primaryColor, width: 1.1),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            text,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: primaryColor,
            ),
          ),
          if (icon != null) ...[
            SizedBox(width: 10),
            Icon(icon, color: primaryColor),
          ],
        ],
      ),
    );
  }
}
