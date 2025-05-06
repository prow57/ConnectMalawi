import 'package:flutter/material.dart';
import '../../constants/theme_constants.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 48.0,
    this.borderRadius = 8.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ThemeConstants.primaryColor,
          foregroundColor: textColor ?? Colors.white,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: ThemeConstants.spacingL,
                vertical: ThemeConstants.spacingM,
              ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: ThemeConstants.body1.copyWith(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
